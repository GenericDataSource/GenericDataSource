//
//  SelectionDidHighlightTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/19/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class SelectionDidHighlightTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let selector = MockSelectionController<Report, CellType>()

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        dataSource.setSelectionHandler(selector)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: GeneralCollectionView) {

        return test(with: collectionView,
                    whenTableView: {
                        dataSource.tableView($0, didHighlightRowAt: indexPath)
            },
                    whenCollectionView: {
                        dataSource.collectionView($0, didHighlightItemAt: indexPath)
        })
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertTrue(selector.didHighlightCalled)
        XCTAssertEqual(indexPath, selector.indexPath)
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertFalse(selector.didHighlightCalled)
    }
}
