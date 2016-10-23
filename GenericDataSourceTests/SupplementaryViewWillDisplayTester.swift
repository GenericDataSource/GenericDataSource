//
//  SupplementaryViewWillDisplayTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

class BaseSupplementaryViewWillDisplayTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let creator = MockSupplementaryViewCreator()

    var kind: String { fatalError("Abstract") }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) {
        fatalError("Abstract")
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) {
        dataSource.collectionView(collectionView, willDisplaySupplementaryView: UICollectionReusableView(), forElementKind: kind, at: indexPath)
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertTrue(creator.willDisplayCalled)
        XCTAssertFalse(creator.didDisplayCalled)
        XCTAssertEqual(kind, kind)
        if collectionView is UITableView {
            XCTAssertEqual(indexPath.section, creator.indexPath?.section)
        } else {
            XCTAssertEqual(indexPath, creator.indexPath)
        }
    }

    func assertNotCalled(collectionView: GeneralCollectionView) {
        XCTAssertFalse(creator.willDisplayCalled)
        XCTAssertFalse(creator.didDisplayCalled)
    }
}

class HeaderSupplementaryViewWillDisplayTester<CellType>: BaseSupplementaryViewWillDisplayTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override var kind: String { return UICollectionElementKindSectionHeader }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        super.init(id: id, numberOfReports: numberOfReports, collectionView: collectionView)
        dataSource.set(headerCreator: creator)
    }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) {
        dataSource.tableView(tableView, willDisplayHeaderView: UITableViewHeaderFooterView(), forSection: indexPath.section)
    }
}

class FooterSupplementaryViewWillDisplayTester<CellType>: BaseSupplementaryViewWillDisplayTester<CellType>  where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override var kind: String { return UICollectionElementKindSectionFooter }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        super.init(id: id, numberOfReports: numberOfReports, collectionView: collectionView)
        dataSource.set(footerCreator: creator)
    }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) {
        dataSource.tableView(tableView, willDisplayFooterView: UITableViewHeaderFooterView(), forSection: indexPath.section)
    }
}
