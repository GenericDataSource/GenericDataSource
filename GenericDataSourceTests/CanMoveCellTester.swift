//
//  CanMoveCellTester.swift
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

    override func ds_collectionView(_ collectionView: GeneralCollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        self.indexPath =  indexPath
        return result
    }
}

class CanMoveCellTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    var result: Bool {
        return true
    }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        (dataSource as! _ReportBasicDataSource<CellType>).result = result
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Bool {
        return dataSource.tableView(tableView, canMoveRowAt: indexPath)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Bool {
        return dataSource.collectionView(collectionView, canMoveItemAt: indexPath)
    }

    func assert(result: Bool, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(result, self.result)
        XCTAssertEqual((dataSource as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
    }
}

class CanMoveCellTester2<CellType>: CanMoveCellTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    override var result: Bool {
        return false
    }
}
