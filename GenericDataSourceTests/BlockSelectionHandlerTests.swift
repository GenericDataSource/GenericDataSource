//
//  BlockSelectionHandlerTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/14/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class BlockSelectionHandlerTests: XCTestCase {

    let collectionView = MockCollectionView()
    let dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

    func testInit() {

        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()
        XCTAssertTrue(instance.defaultShouldSelect)
        XCTAssertTrue(instance.defaultShouldSelect)
        XCTAssertTrue(instance.defaultShouldDeselect)

        XCTAssertNil(instance.itemsModifiedBlock)
        XCTAssertNil(instance.configureBlock)
        XCTAssertNil(instance.shouldHighlightBlock)
        XCTAssertNil(instance.didHighlightBlock)
        XCTAssertNil(instance.didUnhighlightBlock)
        XCTAssertNil(instance.shouldSelectBlock)
        XCTAssertNil(instance.didSelectBlock)
        XCTAssertNil(instance.shouldDeselectBlock)
        XCTAssertNil(instance.didDeselectBlock)
    }

    func testItemsModified() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.itemsModifiedBlock = { [weak dataSource] ds in
            called = true
            XCTAssertEqual(dataSource, ds)
        }

        // test
        instance.dataSourceItemsModified(dataSource)

        // assert called
        XCTAssertTrue(called)
    }

    func testConfigure() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.configureBlock = { [weak dataSource, weak collectionView] (ds, collection, cell, item, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
            XCTAssertEqual(Report(id:1, name: "test"), item)
        }

        // test
        instance.dataSource(dataSource, collectionView: collectionView, configure: TextReportCollectionViewCell(), with: Report(id:1, name: "test"), at: IndexPath(item: 0, section: 10))

        // assert called
        XCTAssertTrue(called)
    }

    func testShouldHighlight() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.shouldHighlightBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
            return true
        }

        // test
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: collectionView, shouldHighlightItemAt: IndexPath(item: 0, section: 10)))

        // assert called
        XCTAssertTrue(called)
    }

    func testDefaultShouldHighlight() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // test
        instance.defaultShouldHighlight = true
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: collectionView, shouldHighlightItemAt: IndexPath(item: 0, section: 10)))

        // test
        instance.defaultShouldHighlight = false
        XCTAssertFalse(instance.dataSource(dataSource, collectionView: collectionView, shouldHighlightItemAt: IndexPath(item: 0, section: 10)))
    }

    func testDidHighlight() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.didHighlightBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
        }

        // test
        instance.dataSource(dataSource, collectionView: collectionView, didHighlightItemAt: IndexPath(item: 0, section: 10))

        // assert called
        XCTAssertTrue(called)
    }

    func testDidUnhighlight() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.didUnhighlightBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
        }

        // test
        instance.dataSource(dataSource, collectionView: collectionView, didUnhighlightItemAt: IndexPath(item: 0, section: 10))

        // assert called
        XCTAssertTrue(called)
    }

    func testShouldSelect() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.shouldSelectBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
            return true
        }

        // test
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: collectionView, shouldSelectItemAt: IndexPath(item: 0, section: 10)))

        // assert called
        XCTAssertTrue(called)
    }

    func testDefaultShouldSelect() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // test
        instance.defaultShouldSelect = true
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: collectionView, shouldSelectItemAt: IndexPath(item: 0, section: 10)))

        // test
        instance.defaultShouldSelect = false
        XCTAssertFalse(instance.dataSource(dataSource, collectionView: collectionView, shouldSelectItemAt: IndexPath(item: 0, section: 10)))
    }

    func testDidSelect() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.didSelectBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
        }

        // test
        instance.dataSource(dataSource, collectionView: collectionView, didSelectItemAt: IndexPath(item: 0, section: 10))

        // assert called
        XCTAssertTrue(called)
    }

    func testShouldDeselect() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.shouldDeselectBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
            return true
        }

        // test
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: collectionView, shouldDeselectItemAt: IndexPath(item: 0, section: 10)))

        // assert called
        XCTAssertTrue(called)
    }

    func testDefaultShouldDeselect() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // test
        instance.defaultShouldDeselect = true
        XCTAssertTrue(instance.dataSource(dataSource, collectionView: collectionView, shouldDeselectItemAt: IndexPath(item: 0, section: 10)))

        // test
        instance.defaultShouldDeselect = false
        XCTAssertFalse(instance.dataSource(dataSource, collectionView: collectionView, shouldDeselectItemAt: IndexPath(item: 0, section: 10)))
    }

    func testDidDeselect() {

        // configure
        let instance = BlockSelectionHandler<Report, TextReportCollectionViewCell>()

        // assert block
        var called = false
        instance.didDeselectBlock = { [weak dataSource, weak collectionView] (ds, collection, index) in
            called = true
            XCTAssertEqual(dataSource, ds)
            XCTAssertEqual(collectionView, collection as? MockCollectionView)
            XCTAssertEqual(IndexPath(item: 0, section: 10), index)
        }

        // test
        instance.dataSource(dataSource, collectionView: collectionView, didDeselectItemAt: IndexPath(item: 0, section: 10))

        // assert called
        XCTAssertTrue(called)
    }

}
