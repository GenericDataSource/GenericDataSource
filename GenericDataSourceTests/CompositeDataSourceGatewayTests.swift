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
                            tableType2: SelectionShouldSelectTester2<TextReportTableViewCell>.self,
                            collectionType1: SelectionShouldSelectTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionShouldSelectTester2<TextReportCollectionViewCell>.self)
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
                            tableType2: SelectionShouldDeselectTester2<TextReportTableViewCell>.self,
                            collectionType1: SelectionShouldDeselectTester<PDFReportCollectionViewCell>.self,
                            collectionType2: SelectionShouldDeselectTester2<TextReportCollectionViewCell>.self)
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

    func testHeaderSupplementaryViewOfKind() {
        // execute the test
        executeTestTemplate(tableType1: HeaderSupplementaryViewOfKindTester<PDFReportTableViewCell>.self,
                            tableType2: HeaderSupplementaryViewOfKindTester<TextReportTableViewCell>.self,
                            collectionType1: HeaderSupplementaryViewOfKindTester<PDFReportCollectionViewCell>.self,
                            collectionType2: HeaderSupplementaryViewOfKindTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testFooterSupplementaryViewOfKind() {
        // execute the test
        executeTestTemplate(tableType1: FooterSupplementaryViewOfKindTester<PDFReportTableViewCell>.self,
                            tableType2: FooterSupplementaryViewOfKindTester<TextReportTableViewCell>.self,
                            collectionType1: FooterSupplementaryViewOfKindTester<PDFReportCollectionViewCell>.self,
                            collectionType2: FooterSupplementaryViewOfKindTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testHeaderSupplementaryViewSize() {
        // execute the test
        executeTestTemplate(tableType1:HeaderSupplementaryViewSizeTester<PDFReportTableViewCell>.self,
                            tableType2: HeaderSupplementaryViewSizeTester<TextReportTableViewCell>.self,
                            collectionType1: HeaderSupplementaryViewSizeTester<PDFReportCollectionViewCell>.self,
                            collectionType2: HeaderSupplementaryViewSizeTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()),
                            singleCollectionExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testFooterSupplementaryViewSize() {
        // execute the test
        executeTestTemplate(tableType1: FooterSupplementaryViewSizeTester<PDFReportTableViewCell>.self,
                            tableType2: FooterSupplementaryViewSizeTester<TextReportTableViewCell>.self,
                            collectionType1: FooterSupplementaryViewSizeTester<PDFReportCollectionViewCell>.self,
                            collectionType2: FooterSupplementaryViewSizeTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()),
                            singleCollectionExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testHeaderSupplementaryViewWillDisplay() {
        // execute the test
        executeTestTemplate(tableType1: HeaderSupplementaryViewWillDisplayTester<PDFReportTableViewCell>.self,
                            tableType2: HeaderSupplementaryViewWillDisplayTester<TextReportTableViewCell>.self,
                            collectionType1: HeaderSupplementaryViewWillDisplayTester<PDFReportCollectionViewCell>.self,
                            collectionType2: HeaderSupplementaryViewWillDisplayTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testFooterSupplementaryViewWillDisplay() {
        // execute the test
        executeTestTemplate(tableType1: FooterSupplementaryViewWillDisplayTester<PDFReportTableViewCell>.self,
                            tableType2: FooterSupplementaryViewWillDisplayTester<TextReportTableViewCell>.self,
                            collectionType1: FooterSupplementaryViewWillDisplayTester<PDFReportCollectionViewCell>.self,
                            collectionType2: FooterSupplementaryViewWillDisplayTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testHeaderSupplementaryViewDidDisplay() {
        // execute the test
        executeTestTemplate(tableType1: HeaderSupplementaryViewDidDisplayTester<PDFReportTableViewCell>.self,
                            tableType2: HeaderSupplementaryViewDidDisplayTester<TextReportTableViewCell>.self,
                            collectionType1: HeaderSupplementaryViewDidDisplayTester<PDFReportCollectionViewCell>.self,
                            collectionType2: HeaderSupplementaryViewDidDisplayTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testFooterSupplementaryViewDidDisplay() {
        // execute the test
        executeTestTemplate(tableType1: FooterSupplementaryViewDidDisplayTester<PDFReportTableViewCell>.self,
                            tableType2: FooterSupplementaryViewDidDisplayTester<TextReportTableViewCell>.self,
                            collectionType1: FooterSupplementaryViewDidDisplayTester<PDFReportCollectionViewCell>.self,
                            collectionType2: FooterSupplementaryViewDidDisplayTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: FirstSingleSectionTesterChooser()))
    }

    func testCanEditItem() {
        // execute the test
        executeTestTemplate(tableType1: CanEditItemTester<PDFReportTableViewCell>.self,
                            tableType2: CanEditItemTester2<TextReportTableViewCell>.self,
                            collectionType1: CanEditItemTester<PDFReportCollectionViewCell>.self,
                            collectionType2: CanEditItemTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testCommitEditing() {
        // execute the test
        executeTestTemplate(tableType1: CommitEditingTester<PDFReportTableViewCell>.self,
                            tableType2: CommitEditingTester<TextReportTableViewCell>.self,
                            collectionType1: CommitEditingTester<PDFReportCollectionViewCell>.self,
                            collectionType2: CommitEditingTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testEdigingStyleForItem() {
        // execute the test
        executeTestTemplate(tableType1: EditingStyleForItemTester<PDFReportTableViewCell>.self,
                            tableType2: EditingStyleForItemTester2<TextReportTableViewCell>.self,
                            collectionType1: EditingStyleForItemTester<PDFReportCollectionViewCell>.self,
                            collectionType2: EditingStyleForItemTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testTitleForDeleteConfirmationButton() {
        // execute the test
        executeTestTemplate(tableType1: TitleForDeleteConfirmationButtonTester<PDFReportTableViewCell>.self,
                            tableType2: TitleForDeleteConfirmationButtonTester2<TextReportTableViewCell>.self,
                            collectionType1: TitleForDeleteConfirmationButtonTester<PDFReportCollectionViewCell>.self,
                            collectionType2: TitleForDeleteConfirmationButtonTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testEditingActions() {
        // execute the test
        executeTestTemplate(tableType1: EditingActionsTester<PDFReportTableViewCell>.self,
                            tableType2: EditingActionsTester2<TextReportTableViewCell>.self,
                            collectionType1: EditingActionsTester<PDFReportCollectionViewCell>.self,
                            collectionType2: EditingActionsTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testShouldIndentWhileEditing() {
        // execute the test
        executeTestTemplate(tableType1: ShouldIndentWhileEditingTester<PDFReportTableViewCell>.self,
                            tableType2: ShouldIndentWhileEditingTester2<TextReportTableViewCell>.self,
                            collectionType1: ShouldIndentWhileEditingTester<PDFReportCollectionViewCell>.self,
                            collectionType2: ShouldIndentWhileEditingTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testWillBeginEditing() {
        // execute the test
        executeTestTemplate(tableType1: WillBeginEditingTester<PDFReportTableViewCell>.self,
                            tableType2: WillBeginEditingTester<TextReportTableViewCell>.self,
                            collectionType1: WillBeginEditingTester<PDFReportCollectionViewCell>.self,
                            collectionType2: WillBeginEditingTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testDidEndEditing() {
        // execute the test
        executeTestTemplate(tableType1: EndBeginEditingTester<PDFReportTableViewCell>.self,
                            tableType2: EndBeginEditingTester<TextReportTableViewCell>.self,
                            collectionType1: EndBeginEditingTester<PDFReportCollectionViewCell>.self,
                            collectionType2: EndBeginEditingTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testCanMoveItem() {
        // execute the test
        executeTestTemplate(tableType1: CanMoveCellTester<PDFReportTableViewCell>.self,
                            tableType2: CanMoveCellTester2<TextReportTableViewCell>.self,
                            collectionType1: CanMoveCellTester<PDFReportCollectionViewCell>.self,
                            collectionType2: CanMoveCellTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testMoveItem() {
        // execute the test
        executeTestTemplate(tableType1: MoveItemTester<PDFReportTableViewCell>.self,
                            tableType2: MoveItemTester<TextReportTableViewCell>.self,
                            collectionType1: MoveItemTester<PDFReportCollectionViewCell>.self,
                            collectionType2: MoveItemTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testWillDisplayCell() {
        // execute the test
        executeTestTemplate(tableType1: WillDisplayCellTester<PDFReportTableViewCell>.self,
                            tableType2: WillDisplayCellTester<TextReportTableViewCell>.self,
                            collectionType1: WillDisplayCellTester<PDFReportCollectionViewCell>.self,
                            collectionType2: WillDisplayCellTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testDidEndDisplayCell() {
        // execute the test
        executeTestTemplate(tableType1: DidEndDisplayCellTester<PDFReportTableViewCell>.self,
                            tableType2: DidEndDisplayCellTester<TextReportTableViewCell>.self,
                            collectionType1: DidEndDisplayCellTester<PDFReportCollectionViewCell>.self,
                            collectionType2: DidEndDisplayCellTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testShouldShowMenu() {
        // execute the test
        executeTestTemplate(tableType1: ShouldShowMenuForItemTester<PDFReportTableViewCell>.self,
                            tableType2: ShouldShowMenuForItemTester2<TextReportTableViewCell>.self,
                            collectionType1: ShouldShowMenuForItemTester<PDFReportCollectionViewCell>.self,
                            collectionType2: ShouldShowMenuForItemTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testCanPerformAction() {
        // execute the test
        executeTestTemplate(tableType1: CanPerformActionTester<PDFReportTableViewCell>.self,
                            tableType2: CanPerformActionTester2<TextReportTableViewCell>.self,
                            collectionType1: CanPerformActionTester<PDFReportCollectionViewCell>.self,
                            collectionType2: CanPerformActionTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testPerformAction() {
        // execute the test
        executeTestTemplate(tableType1: PerformActionTester<PDFReportTableViewCell>.self,
                            tableType2: PerformActionTester<TextReportTableViewCell>.self,
                            collectionType1: PerformActionTester<PDFReportCollectionViewCell>.self,
                            collectionType2: PerformActionTester<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testCanFocus() {
        // execute the test
        executeTestTemplate(tableType1: CanFocusTester<PDFReportTableViewCell>.self,
                            tableType2: CanFocusTester2<TextReportTableViewCell>.self,
                            collectionType1: CanFocusTester<PDFReportCollectionViewCell>.self,
                            collectionType2: CanFocusTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
    }

    func testShouldUpdateFocus() {
        // execute the test
        executeTestTemplate(tableType1: ShouldUpdateFocusTester<PDFReportTableViewCell>.self,
                            tableType2: ShouldUpdateFocusTester2<TextReportTableViewCell>.self,
                            collectionType1: ShouldUpdateFocusTester<PDFReportCollectionViewCell>.self,
                            collectionType2: ShouldUpdateFocusTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()),
                            multiTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()),
                            singleCollectionExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()),
                            multiCollectionExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()))
    }

    func testDidUpdateFocus() {
        // execute the test
        executeTestTemplate(tableType1: DidUpdateFocusTester<PDFReportTableViewCell>.self,
                            tableType2: DidUpdateFocusTester2<TextReportTableViewCell>.self,
                            collectionType1: DidUpdateFocusTester<PDFReportCollectionViewCell>.self,
                            collectionType2: DidUpdateFocusTester2<TextReportCollectionViewCell>.self,
                            singleTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()),
                            multiTableExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()),
                            singleCollectionExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()),
                            multiCollectionExecutor: DefaultCompositeDataSourceTestExecutor(chooser: AlwaysFirstTesterChooser()))
    }
}

extension CompositeDataSourceGatewayTests {

    fileprivate func executeTestTemplate<Tester1: DataSourceTester, Tester2: DataSourceTester, Tester3: DataSourceTester, Tester4: DataSourceTester>(
        tableType1: Tester1.Type,
        tableType2: Tester2.Type,
        collectionType1: Tester3.Type,
        collectionType2: Tester4.Type,
        singleTableExecutor: CompositeDataSourceTestExecutor = DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()),
        multiTableExecutor: CompositeDataSourceTestExecutor = DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()),
        singleCollectionExecutor: CompositeDataSourceTestExecutor = DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()),
        multiCollectionExecutor: CompositeDataSourceTestExecutor = DefaultCompositeDataSourceTestExecutor(chooser: DefaulTesterChooser()))
        where
        Tester1.Result == Tester2.Result,
        Tester1.Result == Tester3.Result,
        Tester1.Result == Tester4.Result {

            let basicIndexPathes = [IndexPath(item: 0, section: 0),
                                    IndexPath(item: 10, section: 2),
                                    IndexPath(item: 20, section: 15)]

            let singleSectionIndexPathes = [IndexPath(item: 0, section: 0),
                                            IndexPath(item: 49, section: 15),
                                            IndexPath(item: 50, section: 15),
                                            IndexPath(item: 150, section: 1)]
            let multiSectionIndexPathes = [IndexPath(item: 0, section: 0),
                                           IndexPath(item: 49, section: 0),
                                           IndexPath(item: 50, section: 1),
                                           IndexPath(item: 150, section: 1)]

            // execute basic UITableView
            executeBasicTemplate(type: tableType1, indexPathes: basicIndexPathes, collectionCreator: { MockTableView() })

            // execute basic UICollectionView
            executeBasicTemplate(type: collectionType1, indexPathes: basicIndexPathes, collectionCreator: { MockCollectionView() })

            // execute UITableView - single section
            executeTemplate(type1: tableType1, type2: tableType2, indexPathes: singleSectionIndexPathes, sectionType: .single, executor: singleTableExecutor, collectionCreator: { MockTableView() })

            // execute UITableView - mult section
            executeTemplate(type1: tableType1, type2: tableType2, indexPathes: multiSectionIndexPathes, sectionType: .multi, executor: multiTableExecutor, collectionCreator: { MockTableView() })

            // execute basic UICollectionView - single section
            executeTemplate(type1: collectionType1, type2: collectionType2, indexPathes: singleSectionIndexPathes, sectionType: .single, executor: singleCollectionExecutor, collectionCreator: { MockCollectionView() })

            // execute basic UICollectionView - mult section
            executeTemplate(type1: collectionType1, type2: collectionType2, indexPathes: multiSectionIndexPathes, sectionType: .multi, executor: multiCollectionExecutor, collectionCreator: { MockCollectionView() })
    }

    private func executeBasicTemplate<Tester: DataSourceTester>(type: Tester.Type, indexPathes: [IndexPath], collectionCreator: () -> GeneralCollectionView) {

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
        indexPathes: [IndexPath],
        sectionType: CompositeDataSource.SectionType,
        executor: CompositeDataSourceTestExecutor,
        collectionCreator: () -> GeneralCollectionView) where Tester1.Result == Tester2.Result {

        for indexPath in indexPathes {
            let dataSource  = CompositeDataSource(sectionType: sectionType)

            let collectionView = collectionCreator()

            let tester1 = Tester1(id: 1, numberOfReports: 50, collectionView: collectionView)
            let tester2 = Tester2(id: 2, numberOfReports: 200, collectionView: collectionView)

            dataSource.add(tester1.dataSource)
            dataSource.add(tester2.dataSource)

            executor.execute(tester1: tester1, tester2: tester2, indexPath: indexPath, collectionView: collectionView, dataSource: dataSource)
        }
    }
}
