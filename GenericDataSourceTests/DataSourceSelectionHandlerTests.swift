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
        
        instance.dataSource(dataSource, collectionView: tableView, configureCell: TextReportTableViewCell(), withItem: Report.generate(numberOfReports: 1)[0], atIndexPath: index)
        
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: tableView, shouldHighlightItemAtIndexPath: index))
        instance.dataSource(dataSource, collectionView: tableView, didHighlightItemAtIndexPath: index)
        instance.dataSource(dataSource, collectionView: tableView, didUnhighlightItemAtIndexPath: index)
        
        
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: tableView, shouldSelectItemAtIndexPath: index))
        instance.dataSource(dataSource, collectionView: tableView, didSelectItemAtIndexPath: index)
        
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: tableView, shouldDeselectItemAtIndexPath: index))
        instance.dataSource(dataSource, collectionView: tableView, didDeselectItemAtIndexPath: index)
    }
    
}
