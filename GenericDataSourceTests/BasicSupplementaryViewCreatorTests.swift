//
//  BasicSupplementaryViewCreatorTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class BasicSupplementaryViewCreatorTests: XCTestCase {

    func testView() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let tableView = MockTableView()
        let creator = ReportBasicSupplementaryViewCreator<ReportTableHeaderFooterView>()
        dataSource.supplementaryViewCreator = creator

        let reports = Report.generate(numberOfReports: 200)
        creator.setSectionedItems(reports)

        // assign as data source
        tableView.dataSource = dataSource
        creator.registerReusableViewsInCollectionView(tableView)

        // test
        let view1 = dataSource.tableView(tableView, viewForHeaderInSection: 45) as? ReportTableHeaderFooterView

        // assert
        XCTAssertEqual(1, view1?.reports.count)
        XCTAssertEqual(1, view1?.indexPaths.count)
        XCTAssertEqual(Report(id: 46, name: "report-46"), view1?.reports[0])
        XCTAssertEqual(45, view1?.indexPaths[0].section)

        // test
        let view2 = dataSource.tableView(tableView, viewForFooterInSection: 10) as? ReportTableHeaderFooterView

        // assert
        XCTAssertEqual(1, view2?.reports.count)
        XCTAssertEqual(1, view2?.indexPaths.count)
        XCTAssertEqual(Report(id: 11, name: "report-11"), view2?.reports[0])
        XCTAssertEqual(10, view2?.indexPaths[0].section)
    }

    func testSize() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let tableView = MockTableView()
        let creator = ReportBasicSupplementaryViewCreator<ReportTableHeaderFooterView>()
        dataSource.supplementaryViewCreator = creator

        // assign as data source
        tableView.dataSource = dataSource

        // test
        let size1 = CGSize(width: 0, height: 200)
        creator.size = size1
        let height1 = dataSource.tableView(tableView, heightForHeaderInSection: 20)

        // assert
        XCTAssertEqual(size1.height, height1)

        // test
        let size2 = CGSize(width: 0, height: 50)
        creator.size = size2
        let height2 = dataSource.tableView(tableView, heightForHeaderInSection: 33)

        // assert
        XCTAssertEqual(size2.height, height2)
    }

    func testInitWithSize() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let collectionView = MockCollectionView()
        let creator = BasicSupplementaryViewCreator<Report, ReportCollectionReusableView>(identifier: "", size: CGSize(width: 100, height: 100))
        dataSource.supplementaryViewCreator = creator

        // assign as data source
        collectionView.dataSource = dataSource

        // test
        let size = dataSource.collectionView(collectionView, layout: UICollectionViewFlowLayout(), referenceSizeForHeaderInSection: 20)

        // assert
        XCTAssertEqual(CGSize(width: 100, height: 100), size)
    }

    func testDefaultConfigure() {
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        let collectionView = MockCollectionView()
        let creator = BasicSupplementaryViewCreator<Report, ReportCollectionReusableView>(size: CGSize(width: 100, height: 100))
        dataSource.supplementaryViewCreator = creator

        let reports = Report.generate(numberOfReports: 200)
        creator.setSectionedItems(reports)

        // assign as data source
        collectionView.dataSource = dataSource
        collectionView.ds_register(supplementaryViewClass: ReportCollectionReusableView.self, forKind: headerKind)

        // test
        let view = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: headerKind, at: IndexPath(item: 0, section: 0))

        // assert
        XCTAssertNotNil(view as? ReportCollectionReusableView)
    }
}
