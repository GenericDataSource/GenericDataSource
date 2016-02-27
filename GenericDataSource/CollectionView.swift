//
//  CollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol ReusableCell { }

public protocol CollectionView: class {
    
    var ds_scrollView: UIScrollView { get }
    
    func ds_localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath
    func ds_globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath
    
    func ds_dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell
    
    func ds_numberOfSections() -> Int
    func ds_numberOfItemsInSection(section: Int) -> Int
    
    func ds_indexPathForReusableCell(cell: ReusableCell) -> NSIndexPath?
    func ds_indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath?
    func ds_indexPathsForVisibleItems() -> [NSIndexPath]
    func ds_indexPathesForSelectedItems() -> [NSIndexPath]
    
    func ds_visibleCells() -> [ReusableCell]
    func ds_cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell?
    
    
    func ds_registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String)
    func ds_registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
    
    func ds_reloadData()
    func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?)
    
    func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation)
    func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation)
    func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation)
    func ds_moveSection(section: Int, toSection newSection: Int)
    
    func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation)
    func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath)
    
    func ds_scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool)
    
    func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition)
    func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool)
    
}

