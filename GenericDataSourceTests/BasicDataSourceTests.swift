//
//  BasicDataSourceTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class BasicDataSourceTests: XCTestCase {

    func testItemSizeFunctionOverriden() {
        class Test: ReportBasicDataSource<TextReportCollectionViewCell> {
            fileprivate override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: 100, height: 100)
            }
        }
        let dataSource = Test()

        XCTAssertTrue(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertTrue(dataSource.ds_shouldConsumeItemSizeDelegateCalls())

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

        let actualSize = dataSource.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(CGSize(width: 100, height: 100), actualSize)
    }
    
    func testItemSize() {
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        XCTAssertFalse(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertFalse(dataSource.ds_shouldConsumeItemSizeDelegateCalls())

        let size = CGSize(width: 10, height: 20)
        dataSource.itemSize = size

        XCTAssertEqual(size, dataSource.itemSize)
        XCTAssertTrue(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertTrue(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

        let actualSize = dataSource.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(size, actualSize)
    }
    
    func testCellHeight() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        
        XCTAssertFalse(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertFalse(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let height: CGFloat = 150
        dataSource.itemHeight = height
        
        XCTAssertEqual(height, dataSource.itemHeight)
        XCTAssertTrue(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertTrue(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let tableView = MockTableView()
        
        let actualHeight = dataSource.tableView(tableView, heightForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(height, actualHeight)
    }
    
    func testItems() {
        
        // test items
        let reports = Report.generate(numberOfReports: 20)
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        dataSource.items = reports
        
        XCTAssertEqual(dataSource.items, reports)
    }
    
    func testItemAtIndexPath() {
    
        let reports = Report.generate(numberOfReports: 20)
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        dataSource.items = reports
    
        let fifth = dataSource.item(at: IndexPath(item: 4, section: 0))
        XCTAssertEqual(reports[4], fifth)
    }
    
    func testReplaceItemAtIndexPath() {
        
        let reports = Report.generate(numberOfReports: 20)
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        dataSource.items = reports
    
        let test = Report(id: 1945, name: "mohamed")
        dataSource.replaceItem(at: IndexPath(item: 15, section: 0), with: test)
        var mutableReports = reports
        mutableReports[15] = test
        XCTAssertEqual(dataSource.items, mutableReports)
    }

    func testQueryForCellsWithTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        dataSource.items = reports

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        dataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(reports.count, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testQueryForCellsWithCollectionView() {

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.numberOfReuseCells = 10

        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        dataSource.items = reports

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        dataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(1, collectionView.numberOfSections)
        XCTAssertEqual(reports.count, collectionView.ds_numberOfItems(inSection: 0))
        let cells = collectionView.cells[0] as! [TextReportCollectionViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
            
        }
    }
    
    func testSelectionItemsModified() {

        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)

        tableDataSource.items = Report.generate(numberOfReports: 10)
        XCTAssertTrue(tableSelector.itemsModifiedCalled)
        
        collectionDataSource.items = Report.generate(numberOfReports: 10)
        XCTAssertTrue(collectionSelector.itemsModifiedCalled)
    }
    
    func testConfigureCellBySelectorCollectionView() {
        
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.numberOfReuseCells = 10
        
        let selection = MockSelectionController<Report, TextReportCollectionViewCell>()
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        dataSource.setSelectionHandler(selection.anyDataSourceSelectionHandler())
        
        let reports = Report.generate(numberOfReports: 200)
        dataSource.items = reports
        
        // assign as data source
        collectionView.dataSource = dataSource
        
        // register the cell
        dataSource.registerReusableViewsInCollectionView(collectionView)
        
        // execute the test
        let indexPath = IndexPath(item: 10, section: 0)
        let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        
        XCTAssertTrue(selection.configureCellCalled)
        XCTAssertEqual(cell, selection.cell)
        XCTAssertEqual(indexPath, selection.indexPath)
        XCTAssertEqual(dataSource.items[(indexPath as NSIndexPath).item], selection.item)
    }
    
    func testConfigureCellBySelectorTableView() {
        
        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10
        
        let selection = MockSelectionController<Report, TextReportTableViewCell>()
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        dataSource.setSelectionHandler(selection)

        let reports = Report.generate(numberOfReports: 200)
        dataSource.items = reports
        
        // assign as data source
        tableView.dataSource = dataSource
        
        // register the cell
        dataSource.registerReusableViewsInCollectionView(tableView)
        
        // execute the test
        let indexPath = IndexPath(item: 10, section: 0)
        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath)
        
        XCTAssertTrue(selection.configureCellCalled)
        XCTAssertEqual(cell, selection.cell)
        XCTAssertEqual(indexPath, selection.indexPath)
        XCTAssertEqual(dataSource.items[(indexPath as NSIndexPath).item], selection.item)
    }
    
    func testSelectionShouldHighlight() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)

        XCTAssertTrue(tableDataSource.tableView(tableView, shouldHighlightRowAt: indexPath))
        XCTAssertTrue(tableSelector.shouldHighlightCalled)
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldHighlightItemAt: indexPath))
        XCTAssertTrue(collectionSelector.shouldHighlightCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionDidHighlight() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didHighlightRowAt: indexPath)
        XCTAssertTrue(tableSelector.didHighlightCalled)
        
        collectionDataSource.collectionView(collectionView, didHighlightItemAt: indexPath)
        XCTAssertTrue(collectionSelector.didHighlightCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionDidUnhighlight() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didUnhighlightRowAt: indexPath)
        XCTAssertTrue(tableSelector.didUnhighlightCalled)
        
        collectionDataSource.collectionView(collectionView, didUnhighlightItemAt: indexPath)
        XCTAssertTrue(collectionSelector.didUnhighlightCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionShouldSelect() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willSelectRowAt: indexPath))
        XCTAssertTrue(tableSelector.shouldSelectCalled)
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldSelectItemAt: indexPath))
        XCTAssertTrue(collectionSelector.shouldSelectCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }

    func testSelectionDidSelect() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didSelectRowAt: indexPath)
        XCTAssertTrue(tableSelector.didSelectCalled)
        
        collectionDataSource.collectionView(collectionView, didSelectItemAt: indexPath)
        XCTAssertTrue(collectionSelector.didSelectCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionShouldDeselect() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)

        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willDeselectRowAt: indexPath))
        XCTAssertTrue(tableSelector.shouldDeselectCalled)
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldDeselectItemAt: indexPath))
        XCTAssertTrue(collectionSelector.shouldDeselectCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionDidDeselect() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.setSelectionHandler(tableSelector)
        collectionDataSource.setSelectionHandler(collectionSelector)
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didDeselectRowAt: indexPath)
        XCTAssertTrue(tableSelector.didDeselectCalled)
        
        collectionDataSource.collectionView(collectionView, didDeselectItemAt: indexPath)
        XCTAssertTrue(collectionSelector.didDeselectCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionShouldHighlightNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        XCTAssertTrue(tableDataSource.tableView(tableView, shouldHighlightRowAt: indexPath))
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldHighlightItemAt: indexPath))
    }
    
    func testSelectionDidHighlightNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didHighlightRowAt: indexPath)
        collectionDataSource.collectionView(collectionView, didHighlightItemAt: indexPath)
    }
    
    func testSelectionDidUnhighlightNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didUnhighlightRowAt: indexPath)
        
        collectionDataSource.collectionView(collectionView, didUnhighlightItemAt: indexPath)
    }
    
    func testSelectionShouldSelectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willSelectRowAt: indexPath))

        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldSelectItemAt: indexPath))
    }
    
    func testSelectionDidSelectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let indexPath = IndexPath(item: 20, section: 10)

        tableDataSource.tableView(tableView, didSelectRowAt: indexPath)
        collectionDataSource.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    func testSelectionWillDeselectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = IndexPath(item: 20, section: 10)

        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willDeselectRowAt: indexPath))
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldDeselectItemAt: indexPath))
    }
    
    func testSelectionDidDeselectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = IndexPath(item: 20, section: 10)
        
        tableDataSource.tableView(tableView, didDeselectRowAt: indexPath)

        collectionDataSource.collectionView(collectionView, didDeselectItemAt: indexPath)
    }
}
