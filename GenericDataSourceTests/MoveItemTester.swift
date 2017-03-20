//
//  MoveItemTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/14/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var sourceIndexPath: IndexPath?
    var destinationIndexPath: IndexPath?

    override func ds_collectionView(_ collectionView: GeneralCollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.sourceIndexPath = sourceIndexPath
        self.destinationIndexPath = destinationIndexPath
    }
}

class MoveItemTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Void {
        return dataSource.tableView(tableView, moveRowAt: indexPath, to: destination(for: indexPath))
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Void {
        return dataSource.collectionView(collectionView, moveItemAt: indexPath, to: destination(for: indexPath))
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual((dataSource as! _ReportBasicDataSource<CellType>).sourceIndexPath, indexPath)
        XCTAssertEqual((dataSource as! _ReportBasicDataSource<CellType>).destinationIndexPath, destination(for: indexPath))
    }

    func destination(for indexPath: IndexPath) -> IndexPath {
        switch indexPath.item {
        case 0: return IndexPath(item: 1, section: indexPath.section)
        case 50: return IndexPath(item: 51, section: indexPath.section)
        default: return IndexPath(item: indexPath.item - 1, section: indexPath.section)
        }
    }
}
