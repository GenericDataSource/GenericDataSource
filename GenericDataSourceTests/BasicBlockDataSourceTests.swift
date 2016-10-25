//
//  BasicBlockDataSourceTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/27/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest

class BasicBlockDataSourceTests: XCTestCase {

    func testBlockBasicDataSource() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let total = 200

        let dataSource = ReportBasicBlockDataSource() { (item: Report, cell: TextReportCollectionViewCell, indexPath) -> Void in
            cell.configureForReport(item, indexPath: indexPath)
        }

        var reports: [Report] = []
        for i in 1...total {
            reports.append(Report(id: i, name: "report-\(i)"))
        }
        dataSource.items = reports

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        dataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(1, collectionView.numberOfSections)
        XCTAssertEqual(total, collectionView.numberOfItems(inSection: 0))
        let cells = collectionView.cells[0] as! [TextReportCollectionViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")

        }
    }

    func testNoReuseBasicDataSource() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let total = 200

        let dataSource = ReportNoReuseBasicDataSource<TextReportTableViewCell>()

        var reports: [Report] = []
        for i in 1...total {
            reports.append(Report(id: i, name: "report-\(i)"))
        }
        dataSource.items = reports

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        //        dataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(total, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]

        for cell in cells {
            XCTAssertEqual(0, cell.reports.count)
            XCTAssertEqual(0, cell.indexPaths.count)
        }
    }
}
