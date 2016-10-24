//
//  BasicSupplementaryViewCreator.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/15/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

open class BasicSupplementaryViewCreator<ItemType, SupplementaryView: ReusableSupplementaryView>: NSObject, SupplementaryViewCreator {

    open var size: CGSize?
    open let identifier: String
    open var items: [[ItemType]] = []

    public init(identifier: String, size: CGSize) {
        self.identifier = identifier
        self.size = size
    }

    public init(identifier: String) {
        self.identifier = identifier
        self.size = nil
    }

    open func setSectionedItems(_ sectionedItems: [ItemType]) {
        items = sectionedItems.map { [$0] }
    }

    open func item(at indexPath: IndexPath) -> ItemType {
        return items[indexPath.section][indexPath.item]
    }

    open func collectionView(_ collectionView: GeneralCollectionView, viewOfKind kind: String, at indexPath: IndexPath) -> ReusableSupplementaryView {
        let view = collectionView.ds_dequeueReusableSupplementaryView(ofKind: kind, withIdentifier: identifier, for: indexPath)

        let supplementaryView: SupplementaryView = cast(view, message: "Cannot cast view '\(view)' to type '\(SupplementaryView.self)'")
        self.collectionView(collectionView, configure: supplementaryView, with: item(at: indexPath), at: indexPath)
        return supplementaryView
    }

    open func collectionView(_ collectionView: GeneralCollectionView, sizeForViewOfKind kind: String, at indexPath: IndexPath) -> CGSize {
        let size: CGSize = cast(self.size, message: "sizeForViewOfKind called and `size` property is nil. Need to set it to non-nil value or override `sizeForViewOfKind` method and return a custom size.")
        return size
    }

    func collectionView(_ collectionView: GeneralCollectionView, configure view: SupplementaryView, with item: ItemType, at indexPath: IndexPath) {
        // does nothing, shall be overriden by subclasses
    }
}
