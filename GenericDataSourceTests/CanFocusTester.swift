//
//  CanFocusTester.swift
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
    var indexPath: IndexPath?

    @available(iOS 9.0, *)
    override func ds_collectionView(_ collectionView: GeneralCollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        self.indexPath =  indexPath
        return result
    }
}

@available(iOS 9.0, *)
class CanFocusTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
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
        return dataSource.tableView(tableView, canFocusRowAt: indexPath)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Bool {
        return dataSource.collectionView(collectionView, canFocusItemAt: indexPath)
    }

    func assert(result: Bool, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(result, self.result)
        XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
    }
}

@available(iOS 9.0, *)
class CanFocusTester2<CellType>: CanEditItemTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    override var result: Bool {
        return false
    }
}
