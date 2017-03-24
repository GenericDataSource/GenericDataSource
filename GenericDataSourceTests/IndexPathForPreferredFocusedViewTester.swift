//
//  IndexPathForPreferredFocusedViewTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/23/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var result: IndexPath? = nil
    var called: Bool = false

    @available(iOS 9.0, *)
    override func ds_indexPathForPreferredFocusedView(in collectionView: GeneralCollectionView) -> IndexPath? {
        called = true
        return result
    }
}

@available(iOS 9.0, *)
class IndexPathForPreferredFocusedViewTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    var result: IndexPath? {
        return IndexPath(item: 4, section: 32)
    }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        (dataSource as! _ReportBasicDataSource<CellType>).result = result
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> IndexPath? {
        return dataSource.indexPathForPreferredFocusedView(in: tableView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> IndexPath? {
        return dataSource.indexPathForPreferredFocusedView(in: collectionView)
    }

    func assert(result: IndexPath?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(IndexPath(item: 4, section: 32), self.result)
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTFail()
    }
}

@available(iOS 9.0, *)
class IndexPathForPreferredFocusedViewTester2<CellType>: IndexPathForPreferredFocusedViewTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: IndexPath?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTFail()
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        // should be called
    }
}

@available(iOS 9.0, *)
class IndexPathForPreferredFocusedViewTester3<CellType>: IndexPathForPreferredFocusedViewTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: IndexPath?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(true, (dataSource as! _ReportBasicDataSource<CellType>).called)
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertEqual(false, (dataSource as! _ReportBasicDataSource<CellType>).called)
    }
}
