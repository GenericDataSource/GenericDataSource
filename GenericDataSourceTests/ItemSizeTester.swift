//
//  ItemSizeTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/19/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class ItemSizeTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()

    var size: CGSize = .zero

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)

        size = CGSize(width: CGFloat(arc4random()), height: CGFloat(arc4random()))
        dataSource.itemSize = size
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> CGSize {
        return CGSize(width: 0, height: dataSource.tableView(tableView, heightForRowAt: indexPath))
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> CGSize {
        return dataSource.ds_collectionView(collectionView, sizeForItemAt: indexPath)
    }

    func assert(result: CGSize, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        if collectionView is UITableView {
            XCTAssertEqual(result.height, size.height)
        } else {
            XCTAssertEqual(result, size)
        }
    }
}
