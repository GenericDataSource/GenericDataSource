//
//  SupplementaryViewOfKindTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/20/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class SupplementaryViewOfKindTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let creator = MockSupplementaryViewCreator()

    var view: ReusableSupplementaryView?

    let kind = UICollectionElementKindSectionHeader

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        dataSource.supplementaryViewCreator = creator
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> ReusableSupplementaryView? {
        view = UITableViewHeaderFooterView()
        creator.view = view
        return dataSource.tableView(tableView, viewForHeaderInSection: indexPath.section) as? ReusableSupplementaryView
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> ReusableSupplementaryView? {
        view = UICollectionReusableView()
        creator.view = view
        return dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }

    func assert(result: ReusableSupplementaryView?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(result as? UIView, view as? UIView)
        if collectionView is UITableView {
            XCTAssertEqual(indexPath.section, creator.indexPath?.section)
        } else {
            XCTAssertEqual(indexPath, creator.indexPath)
        }
        XCTAssertEqual(kind, kind)
    }
}
