//
//  ShouldUpdateFocusTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/15/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var result: Bool = false
    var called: Bool = false

    @available(iOS 9.0, *)
    override func ds_collectionView(_ collectionView: GeneralCollectionView, shouldUpdateFocusIn context: GeneralCollectionViewFocusUpdateContext) -> Bool {
        called = true
        return result
    }
}

@available(iOS 9.0, *)
class ShouldUpdateFocusTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    var result: Bool {
        return true
    }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        ((dataSource as Any) as! _ReportBasicDataSource<CellType>).result = result
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Bool {
        return dataSource.tableView(tableView, shouldUpdateFocusIn: UITableViewFocusUpdateContext())
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Bool {
        return dataSource.collectionView(collectionView, shouldUpdateFocusIn: UICollectionViewFocusUpdateContext())
    }

    func assert(result: Bool, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(true, self.result)
    }
 
    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTFail()
    }
}

@available(iOS 9.0, *)
class ShouldUpdateFocusTester2<CellType>: ShouldUpdateFocusTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: Bool, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTFail()
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        // should be called
    }
}

@available(iOS 9.0, *)
class ShouldUpdateFocusTester3<CellType>: ShouldUpdateFocusTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: Bool, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(true, ((dataSource as Any) as! _ReportBasicDataSource<CellType>).called)
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertEqual(false, ((dataSource as Any) as! _ReportBasicDataSource<CellType>).called)
    }
}
