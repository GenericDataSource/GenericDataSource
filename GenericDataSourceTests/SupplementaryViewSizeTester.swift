//
//  SupplementaryViewSizeTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class BaseSupplementaryViewSizeTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let creator = MockSupplementaryViewCreator()

    var size: CGSize?

    var kind: String { fatalError("Abstract") }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        dataSource.supplementaryViewCreator = creator
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> CGSize? {
        fatalError("Abstract")
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> CGSize? {
        fatalError("Abstract")
    }

    func assert(result: CGSize?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertEqual(result, size)
        XCTAssertEqual(indexPath.section, creator.indexPath?.section)
        XCTAssertEqual(kind, kind)
    }
}

class HeaderSupplementaryViewSizeTester<CellType>: BaseSupplementaryViewSizeTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override var kind: String { return UICollectionElementKindSectionHeader }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> CGSize? {
        size = CGSize(width: 0, height: 100)
        creator.size = size
        return CGSize(width:0, height: dataSource.tableView(tableView, heightForHeaderInSection: indexPath.section))
    }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> CGSize? {
        size = CGSize(width: 0, height: 100)
        creator.size = size
        return dataSource.collectionView(collectionView, layout: UICollectionViewFlowLayout(), referenceSizeForFooterInSection: indexPath.section)
    }
}

class FooterSupplementaryViewSizeTester<CellType>: BaseSupplementaryViewSizeTester<CellType>  where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override var kind: String { return UICollectionElementKindSectionFooter }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> CGSize? {
        size = CGSize(width: 0, height: 100)
        creator.size = size
        return CGSize(width:0, height: dataSource.tableView(tableView, heightForFooterInSection: indexPath.section))
    }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> CGSize? {
        size = CGSize(width: 0, height: 100)
        creator.size = size
        return dataSource.collectionView(collectionView, layout: UICollectionViewFlowLayout(), referenceSizeForFooterInSection: indexPath.section)
    }
}
