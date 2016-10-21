//
//  SelectionItemsModifiedTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/20/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class SelectionItemsModifiedTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let selector = MockSelectionController<Report, CellType>()

    private var tested = false

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        dataSource.setSelectionHandler(selector)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, generalCollectionView: GeneralCollectionView) {
        tested = true
        self.dataSource.items = Report.generate(numberOfReports: self.dataSource.items.count)
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(tested, selector.itemsModifiedCalled)
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertEqual(tested, selector.itemsModifiedCalled)
    }
}
