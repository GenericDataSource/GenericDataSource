//
//  DataSourceSelectionHandlerTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

private class DataSourceSelectionHandlerTester: DataSourceSelectionHandler {

    typealias ItemType = Report
    typealias CellType = TextReportTableViewCell
}

class DataSourceSelectionHandlerTests: XCTestCase {

    func testDataSourceSelectionHandler() {
        let tableView = UITableView()
        let dataSource = BasicDataSource<Report, TextReportTableViewCell>(reuseIdentifier: "")
        let instance = DataSourceSelectionHandlerTester()
        let index = IndexPath(item: 0, section: 0)

        // test
        instance.dataSourceItemsModified(dataSource)

        instance.dataSource(dataSource, collectionView: tableView, configure: TextReportTableViewCell(), with: Report.generate(numberOfReports: 1)[0], at: index)

        XCTAssertTrue(instance.dataSource(dataSource, collectionView: tableView, shouldHighlightItemAt: index))
        instance.dataSource(dataSource, collectionView: tableView, didHighlightItemAt: index)
        instance.dataSource(dataSource, collectionView: tableView, didUnhighlightItemAt: index)


        XCTAssertTrue(instance.dataSource(dataSource, collectionView: tableView, shouldSelectItemAt: index))
        instance.dataSource(dataSource, collectionView: tableView, didSelectItemAt: index)

        XCTAssertTrue(instance.dataSource(dataSource, collectionView: tableView, shouldDeselectItemAt: index))
        instance.dataSource(dataSource, collectionView: tableView, didDeselectItemAt: index)
    }

}
