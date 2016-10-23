//
//  SupplementaryViewCreator.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/15/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol SupplementaryViewCreator {

    func collectionView(_ collectionView: GeneralCollectionView, viewOfKind kind: String, at indexPath: IndexPath) -> ReusableSupplementaryView

    func collectionView(_ collectionView: GeneralCollectionView, sizeForViewOfKind kind: String, at indexPath: IndexPath) -> CGSize

    func collectionView(_ collectionView: GeneralCollectionView, willDisplayView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath)

    func collectionView(_ collectionView: GeneralCollectionView, didEndDisplayingView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath)
}

extension SupplementaryViewCreator {

    public func collectionView(_ collectionView: GeneralCollectionView, willDisplayView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath) {
        // does nothing, making them optional
    }

    public func collectionView(_ collectionView: GeneralCollectionView, didEndDisplayingView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath) {
        // does nothing, making them optional
    }
}
