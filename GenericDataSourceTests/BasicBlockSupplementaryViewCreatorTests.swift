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

        let dataSource = CompositeDataSource(sectionType: .multi)

        let dataSource1 = ReportBasicDataSource<PDFReportCollectionViewCell>()
        dataSource1.items = Report.generate(numberOfReports: 50)
        dataSource.add(dataSource1)
        let creator1 = BasicBlockSupplementaryViewCreator<Report, ReportCollectionReusableView>(identifier: NSStringFromClass(ReportTableHeaderFooterView.self), size: CGSize(width: 100, height: 100)) { (item, view, indexPath) in
            view.configureForReport(item, indexPath: indexPath)
        }
        creator1.setSectionedItems([Report(id: 1, name: "name1")])
        dataSource1.supplementaryViewCreator = creator1

        let dataSource2 = ReportBasicDataSource<TextReportCollectionViewCell>()
        dataSource2.items = Report.generate(numberOfReports: 50)
        dataSource.add(dataSource2)
        let creator2 = BasicBlockSupplementaryViewCreator<Report, ReportCollectionReusableView>(identifier: NSStringFromClass(ReportTableHeaderFooterView.self)) { (item, view, indexPath) in
            view.configureForReport(item, indexPath: indexPath)
        }
        creator2.setSectionedItems([Report(id: 2, name: "name2")])
        dataSource2.supplementaryViewCreator = creator2

        let collectionView = MockCollectionView()

        // assign as data source
        collectionView.dataSource = dataSource
        collectionView.register(ReportCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(ReportTableHeaderFooterView.self))

        // test
        let view1 = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? ReportCollectionReusableView

        // assert
        XCTAssertEqual(1, view1?.reports.count)
        XCTAssertEqual(1, view1?.indexPaths.count)
        XCTAssertEqual(Report(id: 1, name: "name1"), view1?.reports[0])
        XCTAssertEqual(IndexPath(item: 0, section: 0), view1?.indexPaths[0])
        XCTAssertEqual(CGSize(width: 100, height: 100), creator1.size)

        // test
        let view2 = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? ReportCollectionReusableView

        // assert
        XCTAssertEqual(1, view2?.reports.count)
        XCTAssertEqual(1, view2?.indexPaths.count)
        XCTAssertEqual(Report(id: 2, name: "name2"), view2?.reports[0])
        XCTAssertEqual(IndexPath(item: 0, section: 0), view2?.indexPaths[0])
        XCTAssertNil(creator2.size)
    }

}
