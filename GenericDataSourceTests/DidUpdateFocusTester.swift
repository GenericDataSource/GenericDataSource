//
//  DidUpdateFocusTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/15/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

@available(iOS 9.0, *)
private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var called = false

    override func ds_collectionView(_ collectionView: GeneralCollectionView, didUpdateFocusIn context: GeneralCollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        called = true
    }
}

@available(iOS 9.0, *)
class DidUpdateFocusTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Void {
        return dataSource.tableView(tableView, didUpdateFocusIn: UITableViewFocusUpdateContext(), with: UIFocusAnimationCoordinator())
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Void {
        return dataSource.collectionView(collectionView, didUpdateFocusIn: UICollectionViewFocusUpdateContext(), with: UIFocusAnimationCoordinator())
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTFail()
    }
}

@available(iOS 9.0, *)
class DidUpdateFocusTester2<CellType>: DidUpdateFocusTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTFail()
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        // should be called
    }
}

@available(iOS 9.0, *)
class DidUpdateFocusTester3<CellType>: DidUpdateFocusTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(true, ((dataSource as Any) as! _ReportBasicDataSource<CellType>).called)
    }

    override func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertEqual(false, ((dataSource as Any) as! _ReportBasicDataSource<CellType>).called)
    }
}
