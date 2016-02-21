//
//  DataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol DataSource : NSObjectProtocol {
    
    func ds_canHandleCellSize() -> Bool
    
    weak var reusableViewDelegate: DataSourceReusableViewDelegate? { get set }
    
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


public protocol DataSourceReusableViewDelegate : class {
    
    func reloadData()

    // animate batch updates
    func performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    
    func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation)
    func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation)
    func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation)
    func moveSection(section: Int, toSection newSection: Int)
    
    func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    func moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath)
}