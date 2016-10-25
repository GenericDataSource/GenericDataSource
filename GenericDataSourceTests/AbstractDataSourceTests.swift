//
//  AbstractDataSourceTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/27/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

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
    }

    func testScrollViewDelegateSetDidScroll() {

        XCTAssertFalse(delegate.called)
        tableView.delegate?.scrollViewDidScroll?(tableView)
        XCTAssertTrue(delegate.called)
    }

    func testScrollViewDelegateSetViewForZooming() {

        XCTAssertFalse(delegate.called)
        _ = tableView.delegate?.viewForZooming?(in: tableView)
        XCTAssertTrue(delegate.called)
    }
}
