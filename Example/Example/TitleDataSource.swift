//
//  TitleDataSource.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import Foundation
import GenericDataSource

class TitleDataSource: BasicDataSource<String, TitleCollectionViewCell> {
    
    // This is needed as of swift 2.2, because if you subclassed a generic class, initializers are not inherited.
    override init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    override func ds_collectionView(collectionView collectionView: GeneralCollectionView, configureCell cell: TitleCollectionViewCell, withItem item: String, atIndexPath indexPath: NSIndexPath) {
        cell.textLabel?.text = item
    }
    
    override func ds_shouldConsumeItemSizeDelegateCalls() -> Bool {
        return true
    }

    override func ds_collectionView(collectionView: GeneralCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.ds_scrollView.bounds.width - 40, height: 50)
    }
}