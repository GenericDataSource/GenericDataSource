//
//  AbstractDataSourceTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/27/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
import GenericDataSource

private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {

    fileprivate var called = false

    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        called = true
    }

    @objc func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        called = true
        return nil
    }
}

private class _AbstractDataSource: AbstractDataSource {

}

class AbstractDataSourceTests: XCTestCase {

    var instance: ReportBasicDataSource<PDFReportCollectionViewCell>!
    var tableView: UITableView!
    fileprivate var delegate: ScrollViewDelegate!

    override func setUp() {
        super.setUp()
        delegate = ScrollViewDelegate()
        instance = ReportBasicDataSource<PDFReportCollectionViewCell>()
        instance.scrollViewDelegate = delegate
        tableView = UITableView()
        tableView.ds_useDataSource(instance)
    }

    func testScrollViewDelegateNotSet() {
        instance.scrollViewDelegate = nil

        XCTAssertFalse(delegate.called)
        tableView.delegate?.scrollViewDidScroll?(tableView)
        XCTAssertFalse(delegate.called)
        XCTAssertNil(instance.forwardingTarget(for: #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))))
    }

    func testScrollViewDelegateSetDidScroll() {

        XCTAssertFalse(delegate.called)
        tableView.delegate?.scrollViewDidScroll?(tableView)
        XCTAssertTrue(delegate.called)
        XCTAssertEqual(delegate, instance.forwardingTarget(for: #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))) as? ScrollViewDelegate)
    }

    func testScrollViewDelegateSetViewForZooming() {

        XCTAssertFalse(delegate.called)
        _ = tableView.delegate?.viewForZooming?(in: tableView)
        XCTAssertTrue(delegate.called)
    }

    func testShouldConsumeItemSizeDelegate() {
        let instance = _AbstractDataSource()
        XCTAssertFalse(instance.ds_shouldConsumeItemSizeDelegateCalls())
    }

    func testCanMoveItem() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertFalse(instance.ds_collectionView(tableView, canMoveItemAt: indexPath))
        // cannot verify the following
        instance.ds_collectionView(tableView, moveItemAt: indexPath, to: indexPath)
    }

    func testDisplayingCells() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)

        // cannot verify the following
        instance.ds_collectionView(tableView, willDisplay: UITableViewCell(), forItemAt: indexPath)
        instance.ds_collectionView(tableView, didEndDisplaying: UITableViewCell(), forItemAt: indexPath)
    }

    func testShouldShowMenu() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertFalse(instance.ds_collectionView(tableView, shouldShowMenuForItemAt: indexPath))
    }

    func testShouldCanPerformAction() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        let selector = #selector(copy)
        XCTAssertFalse(instance.ds_collectionView(tableView, canPerformAction: selector, forItemAt: indexPath, withSender: self))
        // cannot verify the following
        instance.ds_collectionView(tableView, performAction: selector, forItemAt: indexPath, withSender: self)
    }

    @available(iOS 9.0, *)
    func testCanFocus() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertFalse(instance.ds_collectionView(tableView, canFocusItemAt: indexPath))
    }

    @available(iOS 9.0, *)
    func testIndexPathForPreferredFocusedView() {
        class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

            override func ds_indexPathForPreferredFocusedView(in collectionView: GeneralCollectionView) -> IndexPath? {
                return IndexPath(item: 2, section: 22)
            }
        }

        let ds = _ReportBasicDataSource<PDFReportTableViewCell>()

        let result1 = ds.indexPathForPreferredFocusedView(in: MockTableView())
        XCTAssertEqual(IndexPath(item: 2, section: 22), result1)

        let result2 = ds.indexPathForPreferredFocusedView(in: MockCollectionView())
        XCTAssertEqual(IndexPath(item: 2, section: 22), result2)

        let instance = _AbstractDataSource()
        XCTAssertNil(instance.indexPathForPreferredFocusedView(in: MockCollectionView()))
    }

    func testCanEdit() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertTrue(instance.tableView(tableView, canEditRowAt: indexPath))
    }

    func testEditingStyle() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertEqual(UITableViewCellEditingStyle.delete, instance.tableView(tableView, editingStyleForRowAt: indexPath))

        class _AbstractDataSource2: AbstractDataSource {
            override func ds_collectionView(_ collectionView: GeneralCollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
                return false
            }
        }

        let ds = _AbstractDataSource2()
        XCTAssertEqual(UITableViewCellEditingStyle.none, ds.tableView(tableView, editingStyleForRowAt: indexPath))
    }

    func testTitleForDeleteConfirmation() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertNil(instance.tableView(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath))
    }

    func testEditingActions() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertNil(instance.tableView(tableView, editActionsForRowAt: indexPath))
    }

    func testShouldIndentWhileEditing() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        XCTAssertTrue(instance.tableView(tableView, shouldIndentWhileEditingRowAt: indexPath))
    }

    func testWillBeginEditing() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        instance.tableView(tableView, willBeginEditingRowAt: indexPath)
    }

    func testDidEndEditing() {
        let instance = _AbstractDataSource()
        let tableView = MockTableView()
        let indexPath = IndexPath(item: 10, section: 6)
        instance.tableView(tableView, didEndEditingRowAt: indexPath)
        instance.tableView(tableView, didEndEditingRowAt: nil)
    }
}
