//
//  MockSupplementaryViewCreator.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/20/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource

class MockSupplementaryViewCreator: SupplementaryViewCreator {

    var willDisplayCalled   = false
    var didDisplayCalled    = false

    var kind: String?
    var indexPath: IndexPath?
    var view: ReusableSupplementaryView?
    var size: CGSize?


    func collectionView(_ collectionView: GeneralCollectionView, viewOfKind kind: String, at indexPath: IndexPath) -> ReusableSupplementaryView {
        self.kind = kind
        self.indexPath = indexPath
        return view!
    }

    func collectionView(_ collectionView: GeneralCollectionView, sizeForViewOfKind kind: String, at indexPath: IndexPath) -> CGSize {
        self.kind = kind
        self.indexPath = indexPath
        return size!
    }

    func collectionView(_ collectionView: GeneralCollectionView, willDisplayView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath) {
        self.kind = kind
        self.indexPath = indexPath
        willDisplayCalled = true
    }

    func collectionView(_ collectionView: GeneralCollectionView, didEndDisplayingView view: ReusableSupplementaryView, ofKind kind: String, at indexPath: IndexPath) {
        self.kind = kind
        self.indexPath = indexPath
        didDisplayCalled = true
    }
}
