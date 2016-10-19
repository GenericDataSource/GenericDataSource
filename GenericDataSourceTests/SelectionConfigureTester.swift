//
//  SelectionConfigureTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/18/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class SelectionConfigureTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let selector = MockSelectionController<Report, CellType>()

    required init(numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        dataSource.setSelectionHandler(selector)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: GeneralCollectionView) -> ReusableCell? {

        return test(with: collectionView,
             whenTableView: {
                dataSource.tableView($0, cellForRowAt: indexPath)
            },
             whenCollectionView: {
                dataSource.collectionView($0, cellForItemAt: indexPath)
        })
    }

    func assert(result: ReusableCell?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertTrue(selector.configureCellCalled)
        XCTAssertEqual(result as? CellType, selector.cell)
        XCTAssertEqual(dataSource.items[indexPath.item], selector.item)
        XCTAssertEqual(indexPath, selector.indexPath)
        selector.configureCellCalled = false
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertFalse(selector.configureCellCalled)
    }
}
