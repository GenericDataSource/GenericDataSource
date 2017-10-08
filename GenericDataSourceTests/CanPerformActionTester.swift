//
//  CanPerformActionTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/14/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var result: Bool = false
    var indexPath: IndexPath?
    var action: Selector?
    var sender: Any?

    override func ds_collectionView(_ collectionView: GeneralCollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        self.indexPath =  indexPath
        self.action = action
        self.sender = sender
        return result
    }
}

class CanPerformActionTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
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
        return dataSource.tableView(tableView, canPerformAction: #selector(selector), forRowAt: indexPath, withSender: tableView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Bool {
        return dataSource.collectionView(collectionView, canPerformAction: #selector(selector), forItemAt: indexPath, withSender: collectionView)
    }

    func assert(result: Bool, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(result, self.result)
        XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
        XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).action,  #selector(selector))
        XCTAssertIdentical(((dataSource as Any) as! _ReportBasicDataSource<CellType>).sender as? GeneralCollectionView, collectionView)
    }

    @objc func selector() {
    }
}

class CanPerformActionTester2<CellType>: CanPerformActionTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    override var result: Bool {
        return false
    }
}
