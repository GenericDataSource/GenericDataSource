//
//  CompositeSingleSectionTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/18/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
import GenericDataSource

class CompositeSingleSectionTests: XCTestCase {

    private func executeTestTemplate<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        collectionView collectionCreator: @autoclosure () -> GeneralCollectionView,
        type1: Tester1.Type,
        type2: Tester2.Type)
        where Tester1.Result == Tester2.Result {

            // single section tests
            let singleSectionIndexPathes = [IndexPath(item: 0, section: 0),
                               IndexPath(item: 49, section: 15),
                               IndexPath(item: 50, section: 15),
                               IndexPath(item: 150, section: 1)]

            for indexPath in singleSectionIndexPathes {
                let dataSource  = CompositeDataSource(sectionType: .single)

                let collectionView = collectionCreator()

                let tester1 = Tester1(numberOfReports: 50, collectionView: collectionView)
                let tester2 = Tester2(numberOfReports: 200, collectionView: collectionView)

                dataSource.add(tester1.dataSource)
                dataSource.add(tester2.dataSource)

                var indexPath2 = IndexPath(item: indexPath.item - tester1.dataSource.ds_numberOfItems(inSection: 0), section: indexPath.section)
                let result = tester1.test(indexPath: indexPath, dataSource: dataSource, collectionView: collectionView)
                if indexPath2.item < 0 {
                    tester2.assertNotCalled(collectionView: collectionView)
                    tester1.assert(result: result, indexPath: indexPath, collectionView: collectionView)
                } else {
                    tester1.assertNotCalled(collectionView: collectionView)
                    tester2.assert(result: result, indexPath: indexPath2, collectionView: collectionView)
                }
                tester1.cleanUp()
                tester2.cleanUp()
            }


            // multi section tests
            let multiSectionIndexPathes = [IndexPath(item: 0, section: 0),
                                            IndexPath(item: 49, section: 0),
                                            IndexPath(item: 50, section: 1),
                                            IndexPath(item: 150, section: 1)]

            for indexPath in multiSectionIndexPathes {
                let dataSource  = CompositeDataSource(sectionType: .multi)

                let collectionView = collectionCreator()

                let tester1 = Tester1(numberOfReports: 50, collectionView: collectionView)
                let tester2 = Tester2(numberOfReports: 200, collectionView: collectionView)

                dataSource.add(tester1.dataSource)
                dataSource.add(tester2.dataSource)

                var indexPath2 = IndexPath(item: indexPath.item, section: indexPath.section - 1)
                let result = tester1.test(indexPath: indexPath, dataSource: dataSource, collectionView: collectionView)
                if indexPath2.section < 0 {
                    tester2.assertNotCalled(collectionView: collectionView)
                    tester1.assert(result: result, indexPath: indexPath, collectionView: collectionView)
                } else {
                    tester1.assertNotCalled(collectionView: collectionView)
                    tester2.assert(result: result, indexPath: indexPath2, collectionView: collectionView)
                }
                tester1.cleanUp()
                tester2.cleanUp()
            }
    }

    func testSelectorConfigureCell() {
        // test table view
        executeTestTemplate(collectionView: MockTableView(),
                            type1: SelectionConfigureTester<PDFReportTableViewCell>.self,
                            type2: SelectionConfigureTester<TextReportTableViewCell>.self)

        // test collection view
        executeTestTemplate(collectionView: MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout()),
                            type1: SelectionConfigureTester<PDFReportCollectionViewCell>.self,
                            type2: SelectionConfigureTester<TextReportCollectionViewCell>.self)
    }
}
