//
//  CompositeDataSourceMultiSectionTableTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/28/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class CompositeDataSourceMultiSectionTableTests: XCTestCase {
    
    func testItemSize()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
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
        
        XCTAssertEqual(height1, dataSource.tableView(tableView, heightForRowAt: IndexPath(item: 0, section: 0)))
        XCTAssertEqual(height1, dataSource.tableView(tableView, heightForRowAt: IndexPath(item: 49, section: 0)))
        XCTAssertEqual(height2, dataSource.tableView(tableView, heightForRowAt: IndexPath(item: 50, section: 1)))
        XCTAssertEqual(height2, dataSource.tableView(tableView, heightForRowAt: IndexPath(item: 100, section: 1)))
    }
    
    func testSelectorConfigureCell()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
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
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        var index = IndexPath(item: 0, section: 0)
        var cell = dataSource.tableView(tableView, cellForRowAt: index)
        XCTAssertTrue(selector1.configureCellCalled)
        XCTAssertEqual(cell, selector1.cell)
        XCTAssertEqual(pdfReportsDataSource.items[(index as NSIndexPath).item], selector1.item)
        XCTAssertEqual(index, selector1.indexPath)
        XCTAssertFalse(selector2.configureCellCalled)
        selector1.configureCellCalled = false
        
        index = IndexPath(item: 49, section: 0)
        cell = dataSource.tableView(tableView, cellForRowAt: index)
        XCTAssertTrue(selector1.configureCellCalled)
        XCTAssertEqual(cell, selector1.cell)
        XCTAssertEqual(pdfReportsDataSource.items[(index as NSIndexPath).item], selector1.item)
        XCTAssertEqual(index, selector1.indexPath)
        XCTAssertFalse(selector2.configureCellCalled)
        selector1.configureCellCalled = false
        
        index = IndexPath(item: 50, section: 1)
        cell = dataSource.tableView(tableView, cellForRowAt: index)
        XCTAssertTrue(selector2.configureCellCalled)
        XCTAssertEqual(cell, selector2.cell)
        var localIndex = IndexPath(item: (index as NSIndexPath).item, section: (index as NSIndexPath).section - 1)
        XCTAssertEqual(textReportsDataSource.items[(localIndex as NSIndexPath).item], selector2.item)
        XCTAssertEqual(localIndex, selector2.indexPath)
        XCTAssertFalse(selector1.configureCellCalled)
        selector2.configureCellCalled = false
        
        index = IndexPath(item: 150, section: 1)
        cell = dataSource.tableView(tableView, cellForRowAt: index)
        XCTAssertTrue(selector2.configureCellCalled)
        XCTAssertEqual(cell, selector2.cell)
        localIndex = IndexPath(item: (index as NSIndexPath).item, section: (index as NSIndexPath).section - 1)
        XCTAssertEqual(textReportsDataSource.items[(localIndex as NSIndexPath).item], selector2.item)
        XCTAssertEqual(localIndex, selector2.indexPath)
        XCTAssertFalse(selector1.configureCellCalled)
        selector2.configureCellCalled = false
    }

    func testShouldHighlight()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAt: IndexPath(item: 0, section: 0)))
        XCTAssertTrue(selector1.shouldHighlightCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldHighlightCalled)
        selector1.shouldHighlightCalled = false
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAt: IndexPath(item: 49, section: 0)))
        XCTAssertTrue(selector1.shouldHighlightCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldHighlightCalled)
        selector1.shouldHighlightCalled = false
        
        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAt: IndexPath(item: 50, section: 1)))
        XCTAssertTrue(selector2.shouldHighlightCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.shouldHighlightCalled)
        selector2.shouldHighlightCalled = false

        XCTAssertTrue(dataSource.tableView(tableView, shouldHighlightRowAt: IndexPath(item: 150, section: 1)))
        XCTAssertTrue(selector2.shouldHighlightCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.shouldHighlightCalled)
        selector2.shouldHighlightCalled = false
    }

    func testDidHighlight()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        dataSource.tableView(tableView, didHighlightRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(selector1.didHighlightCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didHighlightCalled)
        selector1.didHighlightCalled = false
        
        dataSource.tableView(tableView, didHighlightRowAt: IndexPath(item: 49, section: 0))
        XCTAssertTrue(selector1.didHighlightCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didHighlightCalled)
        selector1.didHighlightCalled = false
        
        dataSource.tableView(tableView, didHighlightRowAt: IndexPath(item: 50, section: 1))
        XCTAssertTrue(selector2.didHighlightCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didHighlightCalled)
        selector2.didHighlightCalled = false
        
        dataSource.tableView(tableView, didHighlightRowAt: IndexPath(item: 150, section: 1))
        XCTAssertTrue(selector2.didHighlightCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didHighlightCalled)
        selector2.didHighlightCalled = false
    }
    
    func testDidUnhighlight()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        dataSource.tableView(tableView, didUnhighlightRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(selector1.didUnhighlightCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didUnhighlightCalled)
        selector1.didUnhighlightCalled = false
        
        dataSource.tableView(tableView, didUnhighlightRowAt: IndexPath(item: 49, section: 0))
        XCTAssertTrue(selector1.didUnhighlightCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didUnhighlightCalled)
        selector1.didUnhighlightCalled = false
        
        dataSource.tableView(tableView, didUnhighlightRowAt: IndexPath(item: 50, section: 1))
        XCTAssertTrue(selector2.didUnhighlightCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didUnhighlightCalled)
        selector2.didUnhighlightCalled = false
        
        dataSource.tableView(tableView, didUnhighlightRowAt: IndexPath(item: 150, section: 1))
        XCTAssertTrue(selector2.didUnhighlightCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didUnhighlightCalled)
        selector2.didUnhighlightCalled = false
    }
    
    func testShouldSelect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        XCTAssertEqual(IndexPath(item: 0, section: 0), dataSource.tableView(tableView, willSelectRowAt: IndexPath(item: 0, section: 0)))
        XCTAssertTrue(selector1.shouldSelectCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldSelectCalled)
        selector1.shouldSelectCalled = false
        
        XCTAssertEqual(IndexPath(item: 49, section: 0), dataSource.tableView(tableView, willSelectRowAt: IndexPath(item: 49, section: 0)))
        XCTAssertTrue(selector1.shouldSelectCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldSelectCalled)
        selector1.shouldSelectCalled = false
        
        XCTAssertEqual(IndexPath(item: 50, section: 1), dataSource.tableView(tableView, willSelectRowAt: IndexPath(item: 50, section: 1)))
        XCTAssertTrue(selector2.shouldSelectCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.shouldSelectCalled)
        selector2.shouldSelectCalled = false
        
        XCTAssertEqual(IndexPath(item: 150, section: 1), dataSource.tableView(tableView, willSelectRowAt: IndexPath(item: 150, section: 1)))
        XCTAssertTrue(selector2.shouldSelectCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.shouldSelectCalled)
        selector2.shouldSelectCalled = false
    }
    
    func testDidSelect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        dataSource.tableView(tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(selector1.didSelectCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didSelectCalled)
        selector1.didSelectCalled = false
        
        dataSource.tableView(tableView, didSelectRowAt: IndexPath(item: 49, section: 0))
        XCTAssertTrue(selector1.didSelectCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didSelectCalled)
        selector1.didSelectCalled = false
        
        dataSource.tableView(tableView, didSelectRowAt: IndexPath(item: 50, section: 1))
        XCTAssertTrue(selector2.didSelectCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didSelectCalled)
        selector2.didSelectCalled = false
        
        dataSource.tableView(tableView, didSelectRowAt: IndexPath(item: 150, section: 1))
        XCTAssertTrue(selector2.didSelectCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didSelectCalled)
        selector2.didSelectCalled = false
    }
    
    func testShouldDeselect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        XCTAssertEqual(IndexPath(item: 0, section: 0), dataSource.tableView(tableView, willDeselectRowAt: IndexPath(item: 0, section: 0)))
        XCTAssertTrue(selector1.shouldDeselectCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldDeselectCalled)
        selector1.shouldDeselectCalled = false
        
        XCTAssertEqual(IndexPath(item: 49, section: 0), dataSource.tableView(tableView, willDeselectRowAt: IndexPath(item: 49, section: 0)))
        XCTAssertTrue(selector1.shouldDeselectCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.shouldDeselectCalled)
        selector1.shouldDeselectCalled = false
        
        XCTAssertEqual(IndexPath(item: 50, section: 1), dataSource.tableView(tableView, willDeselectRowAt: IndexPath(item: 50, section: 1)))
        XCTAssertTrue(selector2.shouldDeselectCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.shouldDeselectCalled)
        selector2.shouldDeselectCalled = false
        
        XCTAssertEqual(IndexPath(item: 150, section: 1), dataSource.tableView(tableView, willDeselectRowAt: IndexPath(item: 150, section: 1)))
        XCTAssertTrue(selector2.shouldDeselectCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.shouldDeselectCalled)
        selector2.shouldDeselectCalled = false
    }
    
    func testDidDeselect()  {
        let tableView = MockTableView()
        let dataSource  = CompositeDataSource(type: .multiSection)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        let selector1 = MockSelectionController<Report, PDFReportTableViewCell>()
        let selector2 = MockSelectionController<Report, TextReportTableViewCell>()
        
        pdfReportsDataSource.setSelectionHandler(selector1)
        textReportsDataSource.setSelectionHandler(selector2)
        
        dataSource.tableView(tableView, didDeselectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(selector1.didDeselectCalled)
        XCTAssertEqual(IndexPath(item: 0, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didDeselectCalled)
        selector1.didDeselectCalled = false
        
        dataSource.tableView(tableView, didDeselectRowAt: IndexPath(item: 49, section: 0))
        XCTAssertTrue(selector1.didDeselectCalled)
        XCTAssertEqual(IndexPath(item: 49, section: 0), selector1.indexPath)
        XCTAssertFalse(selector2.didDeselectCalled)
        selector1.didDeselectCalled = false
        
        dataSource.tableView(tableView, didDeselectRowAt: IndexPath(item: 50, section: 1))
        XCTAssertTrue(selector2.didDeselectCalled)
        XCTAssertEqual(IndexPath(item: 50, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didDeselectCalled)
        selector2.didDeselectCalled = false
        
        dataSource.tableView(tableView, didDeselectRowAt: IndexPath(item: 150, section: 1))
        XCTAssertTrue(selector2.didDeselectCalled)
        XCTAssertEqual(IndexPath(item: 150, section: 0), selector2.indexPath)
        XCTAssertFalse(selector1.didDeselectCalled)
        selector2.didDeselectCalled = false
    }
    
    func testOneDataSource() {
        
        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10
        
        let reportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        
        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports
        
        let dataSource  = CompositeDataSource(type: .multiSection)
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
        XCTAssertEqual(reports.count, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]
        
        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
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

        let dataSource  = CompositeDataSource(type: .multiSection)
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
        XCTAssertEqual(2, tableView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 1))
        
        let cells1 = tableView.cells[0]
        for (index, cell) in cells1.enumerated() {
            guard let cell = cell as? PDFReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }

        let cells2 = tableView.cells[1]
        for (index, cell) in cells2.enumerated() {
            guard let cell = cell as? TextReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1 + total / 2, name: "text report-\(index + 1 + total / 2)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }
    
    func testDistinctCellsWithSingleSection() {
        
        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let singleSectionDataSource  = CompositeDataSource(type: .singleSection)
        singleSectionDataSource.addDataSource(pdfReportsDataSource)
        singleSectionDataSource.addDataSource(textReportsDataSource)
        
        let textReportsDataSource2 = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource2.items = Report.generate(numberOfReports: total, name: "another report")

        let dataSource  = CompositeDataSource(type: .multiSection)
        dataSource.addDataSource(singleSectionDataSource)
        dataSource.addDataSource(textReportsDataSource2)

        // assign as data source
        tableView.dataSource = dataSource
        
        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()
        
        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(singleSectionDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource2 === dataSource.dataSources[1])
        XCTAssertEqual(2, tableView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count + textReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource2.items.count, tableView.ds_numberOfItems(inSection: 1))
        let cells1 = tableView.cells[0]
        
        for (index, cell) in cells1.enumerated() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index - total / 2, section: 0)), "Invalid index path at index: \(index)")
            }
        }

        let cells2 = tableView.cells[1]
        for (index, cell) in cells2.enumerated() {
            guard let cell = cell as? TextReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "another report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }
}
