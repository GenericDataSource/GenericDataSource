//
//  DataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol DataSource : class {
    
    func ds_shouldConsumeCellSizeDelegateCalls() -> Bool

    weak var ds_reusableViewDelegate: DataSourceReusableViewDelegate? { get set }
    
    func ds_numberOfSections() -> Int
    func ds_numberOfItems(inSection section: Int) -> Int
    func ds_collectionView(collectionView: CollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell

    func ds_collectionView(collectionView: CollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize

    // MARK:- Selection
    func ds_collectionView(collectionView: CollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    func ds_collectionView(collectionView: CollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    func ds_collectionView(collectionView: CollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    func ds_collectionView(collectionView: CollectionView, willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    func ds_collectionView(collectionView: CollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    
    func ds_collectionView(collectionView: CollectionView, willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    func ds_collectionView(collectionView: CollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
}

public protocol DataSourceReusableViewDelegate : CollectionView {
    
}