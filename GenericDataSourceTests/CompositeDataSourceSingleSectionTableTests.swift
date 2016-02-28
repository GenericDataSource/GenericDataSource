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
        
        var reports: [Report] = []
        for i in 1...total/2 {
            reports.append(Report(id: i, name: "pdf report-\(i)"))
        }
        pdfReportsDataSource.items = reports
        
        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        
        reports = []
        for i in total/2 + 1...total {
            reports.append(Report(id: i, name: "text report-\(i)"))
        }
        textReportsDataSource.items = reports
        
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
