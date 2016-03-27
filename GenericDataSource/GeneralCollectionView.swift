//
//  GeneralCollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol ReusableCell { }

public protocol GeneralCollectionView: class {
    
    var ds_scrollView: UIScrollView { get }
    
    // MARK:- Register, dequeue
    
    func ds_registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String)
    func ds_registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
    
    func ds_dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell
    
    // MARK:- Numbers

    func ds_numberOfSections() -> Int
    func ds_numberOfItemsInSection(section: Int) -> Int
    
    // MARK:- Manpulate items and sections
    
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
    
    // MARK:- Scroll
    
    func ds_scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool)
    
    // MARK:- Select/Deselect

    func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition)
    func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool)
    
    // MARK:- IndexPaths, Cells
    
    func ds_indexPathForCell(cell: ReusableCell) -> NSIndexPath?
    func ds_indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath?
    func ds_indexPathsForVisibleItems() -> [NSIndexPath]
    func ds_indexPathsForSelectedItems() -> [NSIndexPath]
    
    func ds_visibleCells() -> [ReusableCell]
    func ds_cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell?
    
    
    // MARK: - Local, Global
    
    func ds_localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath
    func ds_globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath
    
    func ds_globalSectionForLocalSection(localSection: Int) -> Int
    
}

extension GeneralCollectionView {

    func ds_localIndexPathsForGlobalIndexPaths(globalIndexPaths: [NSIndexPath]) -> [NSIndexPath] {
        return globalIndexPaths.map { ds_localIndexPathForGlobalIndexPath($0) }
    }

    func ds_globalIndexPathsForLocalIndexPaths(localIndexPaths: [NSIndexPath]) -> [NSIndexPath] {
        return localIndexPaths.map {  ds_globalIndexPathForLocalIndexPath($0) }
    }

    func ds_globalSectionSetForLocalSectionSet(localSections: NSIndexSet) -> NSIndexSet {
        let globalSections = NSMutableIndexSet()
        for section in localSections {
            let globalSection = ds_globalSectionForLocalSection(section)
            globalSections.addIndex(globalSection)
        }
        return globalSections
    }
}