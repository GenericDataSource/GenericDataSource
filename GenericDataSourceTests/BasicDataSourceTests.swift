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
    
    func testItemSize() {
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        XCTAssertFalse(dataSource.useDelegateForItemSize)
        XCTAssertFalse(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let size = CGSize(width: 10, height: 20)
        dataSource.itemSize = size

        XCTAssertEqual(size, dataSource.itemSize)
        XCTAssertTrue(dataSource.useDelegateForItemSize)
        XCTAssertTrue(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())

        let actualSize = dataSource.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertEqual(size, actualSize)
    }
    
    func testCellHeight() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        
        XCTAssertFalse(dataSource.useDelegateForItemSize)
        XCTAssertFalse(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let height: CGFloat = 150
        dataSource.itemHeight = height
        
        XCTAssertEqual(height, dataSource.itemHeight)
        XCTAssertTrue(dataSource.useDelegateForItemSize)
        XCTAssertTrue(dataSource.ds_shouldConsumeItemSizeDelegateCalls())
        
        let tableView = MockTableView()
        
        let actualHeight = dataSource.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
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
    
        let fifth = dataSource.itemAtIndexPath(NSIndexPath(forItem: 4, inSection: 0))
        XCTAssertEqual(reports[4], fifth)
    }
    
    func testReplaceItemAtIndexPath() {
        
        let reports = Report.generate(numberOfReports: 20)
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        dataSource.items = reports
    
        let test = Report(id: 1945, name: "mohamed")
        dataSource.replaceItemAtIndexPath(NSIndexPath(forItem: 15, inSection: 0), withItem: test)
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
        XCTAssertEqual(reports.count, tableView.ds_numberOfItemsInSection(0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]

        for (index, cell) in cells.enumerate() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
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
        collectionView.ueryDataSource()

        // assert
        XCTAssertEqual(1, collectionView.numberOfSections())
        XCTAssertEqual(reports.count, collectionView.ds_numberOfItemsInSection(0))
        let cells = collectionView.cells[0] as! [TextReportCollectionViewCell]

        for (index, cell) in cells.enumerate() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
            
        }
    }
    
    func testSelectionShouldHighlight() {
        
        let tableSelector = MockSelectionController<Report, TextReportTableViewCell>()
        let collectionSelector = MockSelectionController<Report, TextReportCollectionViewCell>()
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)

        XCTAssertTrue(tableDataSource.tableView(tableView, shouldHighlightRowAtIndexPath: indexPath))
        XCTAssertTrue(tableSelector.shouldHighlightCalled)
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldHighlightItemAtIndexPath: indexPath))
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
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didHighlightRowAtIndexPath: indexPath)
        XCTAssertTrue(tableSelector.didHighlightCalled)
        
        collectionDataSource.collectionView(collectionView, didHighlightItemAtIndexPath: indexPath)
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
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didUnhighlightRowAtIndexPath: indexPath)
        XCTAssertTrue(tableSelector.didUnhighlightCalled)
        
        collectionDataSource.collectionView(collectionView, didUnhighlightItemAtIndexPath: indexPath)
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
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willSelectRowAtIndexPath: indexPath))
        XCTAssertTrue(tableSelector.shouldSelectCalled)
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldSelectItemAtIndexPath: indexPath))
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
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        XCTAssertTrue(tableSelector.didSelectCalled)
        
        collectionDataSource.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
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
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)

        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willDeselectRowAtIndexPath: indexPath))
        XCTAssertTrue(tableSelector.shouldDeselectCalled)
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldDeselectItemAtIndexPath: indexPath))
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
        tableDataSource.selectionHandler = tableSelector.anyDataSourceSelectionHandler()
        collectionDataSource.selectionHandler = collectionSelector.anyDataSourceSelectionHandler()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didDeselectRowAtIndexPath: indexPath)
        XCTAssertTrue(tableSelector.didDeselectCalled)
        
        collectionDataSource.collectionView(collectionView, didDeselectItemAtIndexPath: indexPath)
        XCTAssertTrue(collectionSelector.didDeselectCalled)
        
        XCTAssertEqual(indexPath, tableSelector.indexPath)
        XCTAssertEqual(indexPath, collectionSelector.indexPath)
    }
    
    func testSelectionShouldHighlightNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        XCTAssertTrue(tableDataSource.tableView(tableView, shouldHighlightRowAtIndexPath: indexPath))
        
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldHighlightItemAtIndexPath: indexPath))
    }
    
    func testSelectionDidHighlightNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didHighlightRowAtIndexPath: indexPath)
        collectionDataSource.collectionView(collectionView, didHighlightItemAtIndexPath: indexPath)
    }
    
    func testSelectionDidUnhighlightNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didUnhighlightRowAtIndexPath: indexPath)
        
        collectionDataSource.collectionView(collectionView, didUnhighlightItemAtIndexPath: indexPath)
    }
    
    func testSelectionShouldSelectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willSelectRowAtIndexPath: indexPath))

        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldSelectItemAtIndexPath: indexPath))
    }
    
    func testSelectionDidSelectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let indexPath = NSIndexPath(forItem: 20, inSection: 10)

        tableDataSource.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        collectionDataSource.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    func testSelectionWillDeselectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)

        XCTAssertEqual(indexPath, tableDataSource.tableView(tableView, willDeselectRowAtIndexPath: indexPath))
        XCTAssertTrue(collectionDataSource.collectionView(collectionView, shouldDeselectItemAtIndexPath: indexPath))
    }
    
    func testSelectionDidDeselectNoSelector() {
        
        let tableView = MockTableView()
        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let tableDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        
        let indexPath = NSIndexPath(forItem: 20, inSection: 10)
        
        tableDataSource.tableView(tableView, didDeselectRowAtIndexPath: indexPath)

        collectionDataSource.collectionView(collectionView, didDeselectItemAtIndexPath: indexPath)
    }
}
