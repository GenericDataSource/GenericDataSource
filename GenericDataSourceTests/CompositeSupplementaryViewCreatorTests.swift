//
//  CompositeSupplementaryViewCreatorTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
import GenericDataSource

class CompositeSupplementaryViewCreatorTests: XCTestCase {

    func testHeaderInit() {
        let creator1 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(headerCreator: creator1)

        XCTAssertEqual(1, instance.creators.count)
        XCTAssertEqual(creator1, instance.creators[UICollectionElementKindSectionHeader] as? MockSupplementaryViewCreator)
    }

    func testFooterInit() {
        let creator1 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(footerCreator: creator1)

        XCTAssertEqual(1, instance.creators.count)
        XCTAssertEqual(creator1, instance.creators[UICollectionElementKindSectionFooter] as? MockSupplementaryViewCreator)
    }

    func testHeaderFooterInit() {
        let creator1 = MockSupplementaryViewCreator()
        let creator2 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(headerCreator: creator1, footerCreator: creator2)

        XCTAssertEqual(2, instance.creators.count)
        XCTAssertEqual(creator1, instance.creators[UICollectionElementKindSectionHeader] as? MockSupplementaryViewCreator)
        XCTAssertEqual(creator2, instance.creators[UICollectionElementKindSectionFooter] as? MockSupplementaryViewCreator)
    }

    func testAdd() {
        let creator1 = MockSupplementaryViewCreator()
        let creator2 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(creators: [:])

        instance.add(creator: creator1, forKind: "kind1")
        instance.add(creator: creator2, forKind: "kind2")

        XCTAssertEqual(2, instance.creators.count)
        XCTAssertEqual(creator1, instance.creators["kind1"] as? MockSupplementaryViewCreator)
        XCTAssertEqual(creator2, instance.creators["kind2"] as? MockSupplementaryViewCreator)
    }

    func testRemoveCreator() {
        let creator1 = MockSupplementaryViewCreator()
        let creator2 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(headerCreator: creator1, footerCreator: creator2)

        instance.removeCreator(forKind: UICollectionElementKindSectionHeader)
        XCTAssertEqual(1, instance.creators.count)
        XCTAssertEqual(creator2, instance.creators[UICollectionElementKindSectionFooter] as? MockSupplementaryViewCreator)
    }

    func testRemoveAll() {
        let creator1 = MockSupplementaryViewCreator()
        let creator2 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(headerCreator: creator1, footerCreator: creator2)

        instance.removeAllCreators()
        XCTAssertEqual(0, instance.creators.count)
    }

    func testCreatorOfKind() {

        let creator1 = MockSupplementaryViewCreator()
        let creator2 = MockSupplementaryViewCreator()

        let instance = CompositeSupplementaryViewCreator(headerCreator: creator1, footerCreator: creator2)

        XCTAssertEqual(creator1, instance.creator(ofKind: UICollectionElementKindSectionHeader) as? MockSupplementaryViewCreator)
        XCTAssertEqual(creator2, instance.creator(ofKind: UICollectionElementKindSectionFooter) as? MockSupplementaryViewCreator)
    }

    func testSupplmentaryViewMethodsDelegations() {
        let creator1 = MockSupplementaryViewCreator()
        creator1.view = UICollectionReusableView()
        let creator2 = MockSupplementaryViewCreator()
        creator2.size = CGSize(width: 10, height: 200)

        let instance = CompositeSupplementaryViewCreator(headerCreator: creator1, footerCreator: creator2)

        let collectionView = MockCollectionView()

        // view
        XCTAssertEqual(creator1.view as? UICollectionReusableView, instance.collectionView(collectionView, viewOfKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 500, section: 50)) as? UICollectionReusableView)
        XCTAssertEqual(IndexPath(item: 500, section: 50), creator1.indexPath)

        // size
        XCTAssertEqual(creator2.size, instance.collectionView(collectionView, sizeForViewOfKind: UICollectionElementKindSectionFooter, at: IndexPath(item: 900, section: 90)))
        XCTAssertEqual(IndexPath(item: 900, section: 90), creator2.indexPath)

        // will display
        instance.collectionView(collectionView, willDisplayView: creator1.view!, ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 999, section: 99))
        XCTAssertEqual(IndexPath(item: 999, section: 99), creator1.indexPath)
        XCTAssertTrue(creator1.willDisplayCalled)
        XCTAssertFalse(creator1.didDisplayCalled)

        // did display
        instance.collectionView(collectionView, didEndDisplayingView: creator1.view!, ofKind: UICollectionElementKindSectionFooter, at: IndexPath(item: 33, section: 22))
        XCTAssertEqual(IndexPath(item: 33, section: 22), creator2.indexPath)
        XCTAssertTrue(creator2.didDisplayCalled)
        XCTAssertFalse(creator2.willDisplayCalled)
    }

    func testDefaultSupplementaryViewCreator() {
        struct Default: SupplementaryViewCreator {
            func collectionView(_ collectionView: GeneralCollectionView, viewOfKind kind: String, at indexPath: IndexPath) -> ReusableSupplementaryView? {
                fatalError()
            }

            func collectionView(_ collectionView: GeneralCollectionView, sizeForViewOfKind kind: String, at indexPath: IndexPath) -> CGSize {
                fatalError()
            }
        }

        let collectionView = MockCollectionView()
        let view = UICollectionReusableView()
        let instance = Default()
        instance.collectionView(collectionView, willDisplayView: view, ofKind: "kind", at: IndexPath(row: 0, section: 0))
        instance.collectionView(collectionView, didEndDisplayingView: view, ofKind: "kind", at: IndexPath(row: 0, section: 0))
    }
}
