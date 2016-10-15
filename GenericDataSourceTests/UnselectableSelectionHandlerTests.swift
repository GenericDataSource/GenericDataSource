//
//  UnselectableSelectionHandlerTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/14/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class UnselectableSelectionHandlerTests: XCTestCase {

    func testShouldHighlight() {

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let instance = UnselectableSelectionHandler<Report, TextReportCollectionViewCell>()

        XCTAssertFalse(instance.dataSource(dataSource, collectionView: collectionView, shouldHighlightItemAt: IndexPath(item: 0, section: 0)))
    }

    func testShouldSelect() {

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let instance = UnselectableSelectionHandler<Report, TextReportCollectionViewCell>()

        XCTAssertFalse(instance.dataSource(dataSource, collectionView: collectionView, shouldSelectItemAt: IndexPath(item: 0, section: 0)))
    }

    func testShouldDeselect() {

        let collectionView = MockCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let instance = UnselectableSelectionHandler<Report, TextReportCollectionViewCell>()

        XCTAssertFalse(instance.dataSource(dataSource, collectionView: collectionView, shouldDeselectItemAt: IndexPath(item: 0, section: 0)))
    }
}
