//
//  SingleSectionDataSourceTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class SingleSectionDataSourceTests : XCTestCase {

    func testSingleSectionWithTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let total = 200

        let reportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()

        var reports: [Report] = []
        for i in 1...total {
            reports.append(Report(id: i, name: "report-\(i)"))
        }
        reportsDataSource.items = reports

        let dataSource  = SingleSectionDataSource()
        dataSource.addDataSource(reportsDataSource)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        (dataSource as DataSource).registerReusableViewsInTableCollectionView(tableView)

        // execute the test
        tableView.queryingDataSource()

        // assert
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(total, tableView.numberOfItemsInSection(0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]

        for (index, cell) in cells.enumerate() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
            
        }
    }

    func testSingleSectionWithCollectionView() {

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.numberOfReuseCells = 10

        let total = 200

        let reportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        var reports: [Report] = []
        for i in 1...total {
            reports.append(Report(id: i, name: "report-\(i)"))
        }
        reportsDataSource.items = reports

        let dataSource  = SingleSectionDataSource()
        dataSource.addDataSource(reportsDataSource)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        (dataSource as DataSource).registerReusableViewsInTableCollectionView(collectionView)

        // execute the test
        collectionView.queryingDataSource()

        // assert
        XCTAssertEqual(1, collectionView.numberOfSections())
        XCTAssertEqual(total, collectionView.numberOfItemsInSection(0))
        let cells = collectionView.cells[0] as! [TextReportCollectionViewCell]

        for (index, cell) in cells.enumerate() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
            
        }
    }

    func testWithDistinctCellsTableView() {

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

        let dataSource  = SingleSectionDataSource()
        dataSource.addDataSource(pdfReportsDataSource)
        dataSource.addDataSource(textReportsDataSource)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        (dataSource as DataSource).registerReusableViewsInTableCollectionView(tableView)

        // execute the test
        tableView.queryingDataSource()

        // assert
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(total, tableView.numberOfItemsInSection(0))
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

    func testWithDistinctCellsCollectionView() {

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()

        var reports: [Report] = []
        for i in 1...total/2 {
            reports.append(Report(id: i, name: "pdf report-\(i)"))
        }
        pdfReportsDataSource.items = reports

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        reports = []
        for i in total/2 + 1...total {
            reports.append(Report(id: i, name: "text report-\(i)"))
        }
        textReportsDataSource.items = reports

        let dataSource  = SingleSectionDataSource()
        dataSource.addDataSource(pdfReportsDataSource)
        dataSource.addDataSource(textReportsDataSource)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        (dataSource as DataSource).registerReusableViewsInTableCollectionView(collectionView)

        // execute the test
        collectionView.queryingDataSource()

        // assert
        XCTAssertEqual(1, collectionView.numberOfSections())
        XCTAssertEqual(total, collectionView.numberOfItemsInSection(0))
        let cells = collectionView.cells[0]

        for (index, cell) in cells.enumerate() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportCollectionViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index, inSection: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportCollectionViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(NSIndexPath(forItem: index - total / 2, inSection: 0)), "Invalid index path at index: \(index)")
            }
        }
    }

}
