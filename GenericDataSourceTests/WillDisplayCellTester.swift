//
//  WillDisplayCellTester.swift
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

    override func ds_collectionView(_ collectionView: GeneralCollectionView, willDisplay cell: ReusableCell, forItemAt indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}

class WillDisplayCellTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Void {
        return dataSource.tableView(tableView, willDisplay: CellType() as! UITableViewCell, forRowAt: indexPath)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Void {
        return dataSource.collectionView(collectionView, willDisplay: CellType() as! UICollectionViewCell, forItemAt: indexPath)
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
    }
}
