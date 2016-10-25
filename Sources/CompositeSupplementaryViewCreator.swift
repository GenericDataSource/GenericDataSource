//
//  CompositeSupplementaryViewCreator.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/15/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

open class CompositeSupplementaryViewCreator: NSObject, SupplementaryViewCreator {

    open private(set) var creators: [String: SupplementaryViewCreator]

    public init(creators: [String: SupplementaryViewCreator]) {
        self.creators = creators
    }

    public convenience init(headerCreator: SupplementaryViewCreator) {
        self.init(creators: [UICollectionElementKindSectionHeader: headerCreator])
    }

    public convenience init(footerCreator: SupplementaryViewCreator) {
        self.init(creators: [UICollectionElementKindSectionFooter: footerCreator])
    }

    public convenience init(headerCreator: SupplementaryViewCreator, footerCreator: SupplementaryViewCreator) {
        self.init(creators: [UICollectionElementKindSectionHeader: headerCreator, UICollectionElementKindSectionFooter: footerCreator])
    }

    open func add(creator: SupplementaryViewCreator, forKind kind: String) {
        creators[kind] = creator
    }

    open func removeCreator(forKind kind: String) {
        creators.removeValue(forKey: kind)
    }

    open func removeAllCreators() {
        creators.removeAll()
    }

    open func creator(ofKind kind: String) -> SupplementaryViewCreator {
        let creator: SupplementaryViewCreator = cast(creators[kind], message: "Cannot find creator of kind '\(kind)'")
        return creator
    }

    open func collectionView(_ collectionView: GeneralCollectionView, viewOfKind kind: String, at indexPath: IndexPath) -> ReusableSupplementaryView {
        let viewCreator = creator(ofKind: kind)
        return viewCreator.collectionView(collectionView, viewOfKind: kind, at: indexPath)
    }

    public func collectionView(_ collectionView: GeneralCollectionView, sizeForViewOfKind kind: String, at indexPath: IndexPath) -> CGSize {
        let viewCreator = creator(ofKind: kind)
        return viewCreator.collectionView(collectionView, sizeForViewOfKind: kind, at: indexPath)
    }

    open func collectionView(_ collectionView: GeneralCollectionView, willDisplayView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath) {
        let viewCreator = creator(ofKind: kind)
        viewCreator.collectionView(collectionView, willDisplayView: view, ofKind: kind, at: indexPath)
    }

    open func collectionView(_ collectionView: GeneralCollectionView, didEndDisplayingView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath) {
        let viewCreator = creator(ofKind: kind)
        viewCreator.collectionView(collectionView, didEndDisplayingView: view, ofKind: kind, at: indexPath)
    }
}
