//
//  BasicBlockSupplementaryViewCreatorTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/24/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
import GenericDataSource

class BasicBlockSupplementaryViewCreatorTests: XCTestCase {
    
    func testBasic() {
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        let collectionView = MockCollectionView()
        let creator = BasicBlockSupplementaryViewCreator<Report, ReportCollectionReusableView>(identifier: NSStringFromClass(ReportTableHeaderFooterView.self), size: CGSize(width: 100, height: 100)) { (item, view, indexPath) in
            view.configureForReport(item, indexPath: indexPath)
        }
        dataSource.supplementaryViewCreator = creator

        let reports = Report.generate(numberOfReports: 200)
        creator.setSectionedItems(reports)

        // assign as data source
        collectionView.dataSource = dataSource
        collectionView.register(ReportCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ReportTableHeaderFooterView.self))

        // test
        let view1 = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 22)) as? ReportCollectionReusableView

        // assert
        XCTAssertEqual(1, view1?.reports.count)
        XCTAssertEqual(1, view1?.indexPaths.count)
        XCTAssertEqual(Report(id: 23, name: "report-23"), view1?.reports[0])
        XCTAssertEqual(22, view1?.indexPaths[0].section)

        // test
        let view2 = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 10)) as? ReportCollectionReusableView

        // assert
        XCTAssertEqual(1, view2?.reports.count)
        XCTAssertEqual(1, view2?.indexPaths.count)
        XCTAssertEqual(Report(id: 11, name: "report-11"), view2?.reports[0])
        XCTAssertEqual(10, view2?.indexPaths[0].section)
    }

    func testBasic2() {
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        let collectionView = MockCollectionView()
        let creator = BasicBlockSupplementaryViewCreator<Report, ReportCollectionReusableView>(identifier: NSStringFromClass(ReportTableHeaderFooterView.self)) { (item, view, indexPath) in
            view.configureForReport(item, indexPath: indexPath)
        }
        dataSource.supplementaryViewCreator = creator

        let reports = Report.generate(numberOfReports: 200)
        creator.setSectionedItems(reports)

        // assign as data source
        collectionView.dataSource = dataSource
        collectionView.register(ReportCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ReportTableHeaderFooterView.self))

        // test
        let view1 = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 22)) as? ReportCollectionReusableView

        // assert
        XCTAssertEqual(1, view1?.reports.count)
        XCTAssertEqual(1, view1?.indexPaths.count)
        XCTAssertEqual(Report(id: 23, name: "report-23"), view1?.reports[0])
        XCTAssertEqual(22, view1?.indexPaths[0].section)

        // test
        let view2 = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 10)) as? ReportCollectionReusableView

        // assert
        XCTAssertEqual(1, view2?.reports.count)
        XCTAssertEqual(1, view2?.indexPaths.count)
        XCTAssertEqual(Report(id: 11, name: "report-11"), view2?.reports[0])
        XCTAssertEqual(10, view2?.indexPaths[0].section)
    }
}
