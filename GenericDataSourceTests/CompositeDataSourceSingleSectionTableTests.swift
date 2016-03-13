//
//  CompositeDataSourceSingleSectionTableTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/28/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class CompositeDataSourceSingleSectionTableTests: XCTestCase {
    
    func testItemSize()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let height1: CGFloat = 19
        let height2: CGFloat = 45
        pdfReportsDataSource.itemHeight = height1
        textReportsDataSource.itemHeight = height2

        XCTAssertEqual(height1, dataSource.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)))
        XCTAssertEqual(height1, dataSource.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 20)))
        XCTAssertEqual(height2, dataSource.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 0)))
        XCTAssertEqual(height2, dataSource.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forItem: 100, inSection: 20)))
    }
    
    func testSelectorConfigureCell()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        var index = NSIndexPath(forItem: 0, inSection: 0)
        var cell = dataSource.tableView(tableView, cellForRowAtIndexPath: index)
        XCTAssertTrue(selector1.configureCellCalled)
        XCTAssertEqual(cell, selector1.cell)
        XCTAssertEqual(pdfReportsDataSource.items[index.item], selector1.item)
        XCTAssertEqual(index, selector1.indexPath)
        XCTAssertFalse(selector2.configureCellCalled)
        selector1.configureCellCalled = false
        
        index = NSIndexPath(forItem: 49, inSection: 15)
        cell = dataSource.tableView(tableView, cellForRowAtIndexPath: index)
        XCTAssertTrue(selector1.configureCellCalled)
        XCTAssertEqual(cell, selector1.cell)
        XCTAssertEqual(pdfReportsDataSource.items[index.item], selector1.item)
        XCTAssertEqual(index, selector1.indexPath)
        XCTAssertFalse(selector2.configureCellCalled)
        selector1.configureCellCalled = false
        
        index = NSIndexPath(forItem: 50, inSection: 15)
        cell = dataSource.tableView(tableView, cellForRowAtIndexPath: index)
        XCTAssertTrue(selector2.configureCellCalled)
        XCTAssertEqual(cell, selector2.cell)
        var localIndex = NSIndexPath(forItem: index.item - pdfReportsDataSource.items.count, inSection: index.section)
        XCTAssertEqual(textReportsDataSource.items[localIndex.item], selector2.item)
        XCTAssertEqual(localIndex, selector2.indexPath)
        XCTAssertFalse(selector1.configureCellCalled)
        selector2.configureCellCalled = false

        index = NSIndexPath(forItem: 150, inSection: 15)
        cell = dataSource.tableView(tableView, cellForRowAtIndexPath: index)
        XCTAssertTrue(selector2.configureCellCalled)
        XCTAssertEqual(cell, selector2.cell)
        localIndex = NSIndexPath(forItem: index.item - pdfReportsDataSource.items.count, inSection: index.section)
        XCTAssertEqual(textReportsDataSource.items[localIndex.item], selector2.item)
        XCTAssertEqual(localIndex, selector2.indexPath)
        XCTAssertFalse(selector1.configureCellCalled)
        selector2.configureCellCalled = false
    }
    
    func testShouldHighlight()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)))
        XCTAssertTrue(selector1.shouldHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldHighlightCalled)
        selector1.shouldHighlightCalled = false
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15)))
        XCTAssertTrue(selector1.shouldHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.shouldHighlightCalled)
        selector1.shouldHighlightCalled = false
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15)))
        XCTAssertTrue(selector2.shouldHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.shouldHighlightCalled)
        selector2.shouldHighlightCalled = false
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22)))
        XCTAssertTrue(selector2.shouldHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.shouldHighlightCalled)
        selector2.shouldHighlightCalled = false
    }
    
    func testDidHighlight()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        dataSource.tableView(tableView, didHighlightRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertTrue(selector1.didHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didHighlightCalled)
        selector1.didHighlightCalled = false
        
        dataSource.tableView(tableView, didHighlightRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15))
        XCTAssertTrue(selector1.didHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.didHighlightCalled)
        selector1.didHighlightCalled = false
        
        dataSource.tableView(tableView, didHighlightRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15))
        XCTAssertTrue(selector2.didHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.didHighlightCalled)
        selector2.didHighlightCalled = false
        
        dataSource.tableView(tableView, didHighlightRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22))
        XCTAssertTrue(selector2.didHighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.didHighlightCalled)
        selector2.didHighlightCalled = false
    }
    
    func testDidUnhighlight()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        dataSource.tableView(tableView, didUnhighlightRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertTrue(selector1.didUnhighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didUnhighlightCalled)
        selector1.didUnhighlightCalled = false
        
        dataSource.tableView(tableView, didUnhighlightRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15))
        XCTAssertTrue(selector1.didUnhighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.didUnhighlightCalled)
        selector1.didUnhighlightCalled = false
        
        dataSource.tableView(tableView, didUnhighlightRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15))
        XCTAssertTrue(selector2.didUnhighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.didUnhighlightCalled)
        selector2.didUnhighlightCalled = false
        
        dataSource.tableView(tableView, didUnhighlightRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22))
        XCTAssertTrue(selector2.didUnhighlightCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.didUnhighlightCalled)
        selector2.didUnhighlightCalled = false
    }
    
    func testShouldSelect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), dataSource.tableView(tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)))
        XCTAssertTrue(selector1.shouldSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldSelectCalled)
        selector1.shouldSelectCalled = false
        
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), dataSource.tableView(tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15)))
        XCTAssertTrue(selector1.shouldSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.shouldSelectCalled)
        selector1.shouldSelectCalled = false
        
        XCTAssertEqual(NSIndexPath(forItem: 50, inSection: 15), dataSource.tableView(tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15)))
        XCTAssertTrue(selector2.shouldSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.shouldSelectCalled)
        selector2.shouldSelectCalled = false
        
        XCTAssertEqual(NSIndexPath(forItem: 150, inSection: 22), dataSource.tableView(tableView, willSelectRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22)))
        XCTAssertTrue(selector2.shouldSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.shouldSelectCalled)
        selector2.shouldSelectCalled = false
    }
    
    func testDidSelect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        dataSource.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertTrue(selector1.didSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didSelectCalled)
        selector1.didSelectCalled = false
        
        dataSource.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15))
        XCTAssertTrue(selector1.didSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.didSelectCalled)
        selector1.didSelectCalled = false
        
        dataSource.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15))
        XCTAssertTrue(selector2.didSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.didSelectCalled)
        selector2.didSelectCalled = false
        
        dataSource.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22))
        XCTAssertTrue(selector2.didSelectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.didSelectCalled)
        selector2.didSelectCalled = false
    }
    
    func testShouldDeselect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), dataSource.tableView(tableView, willDeselectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)))
        XCTAssertTrue(selector1.shouldDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldDeselectCalled)
        selector1.shouldDeselectCalled = false
        
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), dataSource.tableView(tableView, willDeselectRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15)))
        XCTAssertTrue(selector1.shouldDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.shouldDeselectCalled)
        selector1.shouldDeselectCalled = false
        
        XCTAssertEqual(NSIndexPath(forItem: 50, inSection: 15), dataSource.tableView(tableView, willDeselectRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15)))
        XCTAssertTrue(selector2.shouldDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.shouldDeselectCalled)
        selector2.shouldDeselectCalled = false
        
        XCTAssertEqual(NSIndexPath(forItem: 150, inSection: 22), dataSource.tableView(tableView, willDeselectRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22)))
        XCTAssertTrue(selector2.shouldDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.shouldDeselectCalled)
        selector2.shouldDeselectCalled = false
    }
    
    func testDidDeselect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .SingleSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.selectionHandler = selector1.anyDataSourceSelectionHandler()
        textReportsDataSource.selectionHandler = selector2.anyDataSourceSelectionHandler()
        
        dataSource.tableView(tableView, didDeselectRowAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertTrue(selector1.didDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didDeselectCalled)
        selector1.didDeselectCalled = false
        
        dataSource.tableView(tableView, didDeselectRowAtIndexPath: NSIndexPath(forItem: 49, inSection: 15))
        XCTAssertTrue(selector1.didDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 49, inSection: 15), selector1.indexPath)
        XCTAssertFalse(selector2.didDeselectCalled)
        selector1.didDeselectCalled = false
        
        dataSource.tableView(tableView, didDeselectRowAtIndexPath: NSIndexPath(forItem: 50, inSection: 15))
        XCTAssertTrue(selector2.didDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 0, inSection: 15), selector2.indexPath)
        XCTAssertFalse(selector1.didDeselectCalled)
        selector2.didDeselectCalled = false
        
        dataSource.tableView(tableView, didDeselectRowAtIndexPath: NSIndexPath(forItem: 150, inSection: 22))
        XCTAssertTrue(selector2.didDeselectCalled)
        XCTAssertEqual(NSIndexPath(forItem: 100, inSection: 22), selector2.indexPath)
        XCTAssertFalse(selector1.didDeselectCalled)
        selector2.didDeselectCalled = false
    }
    
    func testOneDataSource() {
        
        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10
        
        let reportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        
        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports
        
        let dataSource  = CompositeDataSource(type: .SingleSection)
        dataSource.addDataSource(reportsDataSource)
        
        // assign as data source
        tableView.dataSource = dataSource
        
        // register the cell
        reportsDataSource.registerReusableViewsInCollectionView(tableView)
        
        // execute the test
        tableView.queryDataSource()
        
        // assert
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(reportsDataSource === dataSource.dataSources[0])
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(reports.count, tableView.ds_numberOfItemsInSection(0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]
        
        for (index, cell) in cells.enumerate() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testDistinctCells() {
        
        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10
        
        let total = 55
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let dataSource  = CompositeDataSource(type: .SingleSection)
        dataSource.addDataSource(pdfReportsDataSource)
        dataSource.addDataSource(textReportsDataSource)
        
        // assign as data source
        tableView.dataSource = dataSource
        
        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)
        
        // execute the test
        tableView.queryDataSource()
        
        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(total, tableView.ds_numberOfItemsInSection(0))
        let cells = tableView.cells[0]
        
        for (index, cell) in cells.enumerate() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index - total / 2, inSection: 0)), "Invalid index path at index: \(index)")
            }
        }
    }
}
