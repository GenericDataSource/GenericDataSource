//
//  CompositeDataSourceGatewayTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/18/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
import GenericDataSource

class CompositeDataSourceGatewayTests: XCTestCase {

    func testItemSize() {
        // execute the test
        executeTestTemplate(tableType1: ItemSizeTester<PDFReportTableViewCell>.self,
                            tableType2: ItemSizeTester<TextReportTableViewCell>.self,
                            collectionType1: ItemSizeTester<PDFReportCollectionViewCell>.self,
                            collectionType2: ItemSizeTester<TextReportCollectionViewCell>.self)
    }

    func testSelectorConfigureCell() {
        // execute the test
        executeTestTemplate(tableType1: SelectionConfigureTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionConfigureTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionConfigureTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionConfigureTester<TextReportCollectionViewCell>.self)
    }

    func testShouldHighlight() {
        // execute the test
        executeTestTemplate(tableType1: SelectionShouldHighlightTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionShouldHighlightTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionShouldHighlightTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionShouldHighlightTester<TextReportCollectionViewCell>.self)
    }

    func testDidHighlight() {
        // execute the test
        executeTestTemplate(tableType1: SelectionDidHighlightTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionDidHighlightTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionDidHighlightTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionDidHighlightTester<TextReportCollectionViewCell>.self)
    }

    func testDidUnhighlight() {
        // execute the test
        executeTestTemplate(tableType1: SelectionDidUnhighlightTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionDidUnhighlightTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionDidUnhighlightTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionDidUnhighlightTester<TextReportCollectionViewCell>.self)
    }

    func testShouldSelect() {
        // execute the test
        executeTestTemplate(tableType1: SelectionShouldSelectTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionShouldSelectTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionShouldSelectTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionShouldSelectTester<TextReportCollectionViewCell>.self)
    }

    func testDidSelect() {
        // execute the test
        executeTestTemplate(tableType1: SelectionDidSelectTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionDidSelectTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionDidSelectTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionDidSelectTester<TextReportCollectionViewCell>.self)
    }

    func testShouldDeselect() {
        // execute the test
        executeTestTemplate(tableType1: SelectionShouldDeselectTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionShouldDeselectTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionShouldDeselectTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionShouldDeselectTester<TextReportCollectionViewCell>.self)
    }

    func testDidDeselect() {
        // execute the test
        executeTestTemplate(tableType1: SelectionDidDeselectTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionDidDeselectTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionDidDeselectTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionDidDeselectTester<TextReportCollectionViewCell>.self)
    }

    func testItemsModified() {
        // execute the test
        executeTestTemplate(tableType1: SelectionItemsModifiedTester<PDFReportTableViewCell>.self,
                            tableType2: SelectionItemsModifiedTester<TextReportTableViewCell>.self,
                            collectionType1: SelectionItemsModifiedTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionItemsModifiedTester<TextReportCollectionViewCell>.self)
    }

    func DISABLED_testSupplementaryViewOfKind() {
        // execute the test
        executeTestTemplate(tableType1: SupplementaryViewOfKindTester<PDFReportTableViewCell>.self,
                            tableType2: SupplementaryViewOfKindTester<TextReportTableViewCell>.self,
                            collectionType1: SupplementaryViewOfKindTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SupplementaryViewOfKindTester<TextReportCollectionViewCell>.self)
    }
}



extension CompositeDataSourceGatewayTests {

    fileprivate func executeTestTemplate<Tester1: DataSourceTester, Tester2: DataSourceTester, Tester3: DataSourceTester, Tester4: DataSourceTester>(
        tableType1: Tester1.Type,
        tableType2: Tester2.Type,
        collectionType1: Tester3.Type,
        collectionType2: Tester4.Type)
        where
        Tester1.Result == Tester2.Result,
        Tester1.Result == Tester3.Result,
        Tester1.Result == Tester4.Result {

            // execute basic UITableView
            executeBasicTemplate(type: tableType1, collectionCreator: { MockTableView() })

            // execute basic UICollectionView
            executeBasicTemplate(type: collectionType1, collectionCreator: { MockCollectionView() })

            // execute UITableView
            executeTemplate(type1: tableType1, type2: tableType2, collectionCreator: { MockTableView() })

            // execute basic UICollectionView
            executeTemplate(type1: collectionType1, type2: collectionType2, collectionCreator: { MockCollectionView() })
    }

    private func executeBasicTemplate<Tester: DataSourceTester>(type: Tester.Type, collectionCreator: () -> GeneralCollectionView) {

        let indexPathes = [IndexPath(item: 0, section: 0),
                           IndexPath(item: 10, section: 2),
                           IndexPath(item: 20, section: 15)]

        for indexPath in indexPathes {
            let collectionView = collectionCreator()

            let tester = Tester(id: 1, numberOfReports: 50, collectionView: collectionView)
            let result = tester.test(indexPath: indexPath, dataSource: tester.dataSource, generalCollectionView: collectionView)
            tester.assert(result: result, indexPath: indexPath, collectionView: collectionView)
            tester.cleanUp()
        }
    }



    private func executeTemplate<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        type1: Tester1.Type,
        type2: Tester2.Type,
        collectionCreator: () -> GeneralCollectionView) where Tester1.Result == Tester2.Result {

        let executor = DefaultCompositeDataSourceTestExecuter()

        // single section tests
        let singleSectionIndexPathes = [IndexPath(item: 0, section: 0),
                                        IndexPath(item: 49, section: 15),
                                        IndexPath(item: 50, section: 15),
                                        IndexPath(item: 150, section: 1)]

        for indexPath in singleSectionIndexPathes {
            let dataSource  = CompositeDataSource(sectionType: .single)

            let collectionView = collectionCreator()

            let tester1 = Tester1(id: 1, numberOfReports: 50, collectionView: collectionView)
            let tester2 = Tester2(id: 2, numberOfReports: 200, collectionView: collectionView)

            dataSource.add(tester1.dataSource)
            dataSource.add(tester2.dataSource)

            executor.execute(tester1: tester1, tester2: tester2, indexPath: indexPath, collectionView: collectionView, dataSource: dataSource)
        }


        // multi section tests
        let multiSectionIndexPathes = [IndexPath(item: 0, section: 0),
                                       IndexPath(item: 49, section: 0),
                                       IndexPath(item: 50, section: 1),
                                       IndexPath(item: 150, section: 1)]

        for indexPath in multiSectionIndexPathes {
            let dataSource  = CompositeDataSource(sectionType: .multi)

            let collectionView = collectionCreator()

            let tester1 = Tester1(id: 1, numberOfReports: 50, collectionView: collectionView)
            let tester2 = Tester2(id: 2, numberOfReports: 200, collectionView: collectionView)

            dataSource.add(tester1.dataSource)
            dataSource.add(tester2.dataSource)

            executor.execute(tester1: tester1, tester2: tester2, indexPath: indexPath, collectionView: collectionView, dataSource: dataSource)
        }
    }
}
