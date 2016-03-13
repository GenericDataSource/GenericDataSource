//
//  DataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol DataSource : class {
    
    func ds_shouldConsumeItemSizeDelegateCalls() -> Bool

    weak var ds_reusableViewDelegate: DataSourceReusableViewDelegate? { get set }
    
    func ds_numberOfSections() -> Int
    func ds_numberOfItems(inSection section: Int) -> Int
    func ds_collectionView(collectionView: GeneralCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell

    func ds_collectionView(collectionView: GeneralCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize

    // MARK:- Selection
    func ds_collectionView(collectionView: GeneralCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    func ds_collectionView(collectionView: GeneralCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    func ds_collectionView(collectionView: GeneralCollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    func ds_collectionView(collectionView: GeneralCollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    func ds_collectionView(collectionView: GeneralCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    
    func ds_collectionView(collectionView: GeneralCollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    func ds_collectionView(collectionView: GeneralCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
}

public protocol DataSourceReusableViewDelegate : class, GeneralCollectionView { }