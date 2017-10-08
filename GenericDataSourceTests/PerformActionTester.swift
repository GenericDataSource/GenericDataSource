//
//  PerformActionTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/14/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var indexPath: IndexPath?
    var action: Selector?
    var sender: Any?

    override func ds_collectionView(_ collectionView: GeneralCollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        self.indexPath = indexPath
        self.action = action
        self.sender = sender
    }
}

class PerformActionTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Void {
        return dataSource.tableView(tableView, performAction: #selector(selector), forRowAt: indexPath, withSender: tableView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Void {
        return dataSource.collectionView(collectionView, performAction: #selector(selector), forItemAt: indexPath, withSender: collectionView)
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
        XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).action,  #selector(selector))
        XCTAssertIdentical(((dataSource as Any) as! _ReportBasicDataSource<CellType>).sender as? GeneralCollectionView, collectionView)
    }

    @objc func selector() {
    }
}
