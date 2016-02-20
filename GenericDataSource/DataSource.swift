//
//  DataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol DataSource : NSObjectProtocol {
    
    func canHandleCellSize() -> Bool
    
    weak var reusableViewDelegate: DataSourceReusableViewDelegate? { get set }
    
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    func tableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell

    func tableCollectionView(tableCollectionView: TableCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize

    // MARK:- Selection
    func tableCollectionView(tableCollectionView: TableCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    func tableCollectionView(tableCollectionView: TableCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath)
    func tableCollectionView(tableCollectionView: TableCollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath)
    
    func tableCollectionView(tableCollectionView: TableCollectionView, willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    func tableCollectionView(tableCollectionView: TableCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    
    func tableCollectionView(tableCollectionView: TableCollectionView, willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    func tableCollectionView(tableCollectionView: TableCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath)
}

public protocol DataSourceReusableViewDelegate : class {
    
    func reloadData()
    
    // animate batch updates
    func performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    
    func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?)
    func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?)
    func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?)
    func moveSection(section: Int, toSection newSection: Int)
    
    func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?)
    func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?)
    func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?)
    func moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath)
}