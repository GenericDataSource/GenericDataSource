//
//  BaseSupplementaryViewDidDisplayTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
@testable import GenericDataSource
import XCTest

class BaseSupplementaryViewDidDisplayTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = ReportBasicDataSource<CellType>()
    let creator = MockSupplementaryViewCreator()

    var kind: String { fatalError("Abstract") }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        dataSource.set(headerCreator: creator, footerCreator: creator)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) {
        fatalError("Abstract")
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) {
        dataSource.collectionView(collectionView, didEndDisplayingSupplementaryView: UICollectionReusableView(), forElementOfKind: kind, at: indexPath)
    }

    func assert(result: Void, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        XCTAssertTrue(creator.didDisplayCalled)
        XCTAssertFalse(creator.willDisplayCalled)
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

class HeaderSupplementaryViewDidDisplayTester<CellType>: BaseSupplementaryViewDidDisplayTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override var kind: String { return headerKind }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) {
        dataSource.tableView(tableView, didEndDisplayingHeaderView: UITableViewHeaderFooterView(), forSection: indexPath.section)
    }
}

class FooterSupplementaryViewDidDisplayTester<CellType>: BaseSupplementaryViewDidDisplayTester<CellType>  where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override var kind: String { return footerKind }

    override func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) {
        dataSource.tableView(tableView, didEndDisplayingFooterView: UITableViewHeaderFooterView(), forSection: indexPath.section)
    }
}
