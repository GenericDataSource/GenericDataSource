//
//  _SegmentedGeneralCollectionViewMappingTests.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/22/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class _SegmentedGeneralCollectionViewMappingTests: XCTestCase {

    func testDelegate() {
        let dataSource = SegmentedDataSource()

        let collectionView = MockCollectionView()
        collectionView.ds_useDataSource(dataSource)

        let mapping = _SegmentedGeneralCollectionViewMapping(parentDataSource: dataSource)
        XCTAssertIdentical(collectionView, mapping.delegate)
    }

    func testGlobalSectionForLocalSection() {

        let dataSource = SegmentedDataSource()
        let mapping = _SegmentedGeneralCollectionViewMapping(parentDataSource: dataSource)


        let result = mapping.globalSectionForLocalSection(1)
        XCTAssertEqual(1, result)
    }

    func testLocalIndexForGlobalIndex() {

        let dataSource = SegmentedDataSource()
        let mapping = _SegmentedGeneralCollectionViewMapping(parentDataSource: dataSource)


        let result = mapping.localIndexPathForGlobalIndexPath(IndexPath(item: 2, section: 27))
        XCTAssertEqual(IndexPath(item: 2, section: 27), result)
    }

    func testGlobalIndexForLocalIndex() {

        let dataSource = SegmentedDataSource()
        let mapping = _SegmentedGeneralCollectionViewMapping(parentDataSource: dataSource)


        let result = mapping.globalIndexPathForLocalIndexPath(IndexPath(item: 2, section: 27))
        XCTAssertEqual(IndexPath(item: 2, section: 27), result)
    }
}
