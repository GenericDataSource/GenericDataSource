//
//  UICollectionView+CollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 4/11/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension UICollectionView: GeneralCollectionView {
    
    public func ds_registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        registerNib(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func ds_registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func ds_reloadData() {
        reloadData()
    }
    
    public func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        internal_performBatchUpdates(updates, completion: completion)
    }
    
    public func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        insertSections(sections)
    }
    
    public func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        deleteSections(sections)
    }
    
    public func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        reloadSections(sections)
    }
    
    public func ds_moveSection(section: Int, toSection newSection: Int) {
        moveSection(section, toSection: newSection)
    }
    
    public func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        insertItemsAtIndexPaths(indexPaths)
    }
    
    public func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        deleteItemsAtIndexPaths(indexPaths)
    }
    
    public func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        reloadItemsAtIndexPaths(indexPaths)
    }
    
    public func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }
    
    public func ds_scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        scrollToItemAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: animated)
    }
    
    public func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    public func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        deselectItemAtIndexPath(indexPath, animated: animated)
    }
    
    public var ds_scrollView: UIScrollView { return self }
    
    public func ds_localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        return globalIndex
    }
    
    public func ds_globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        return localIndex
    }
    
    public func ds_globalSectionForLocalSection(localSection: Int) -> Int {
        return localSection
    }
    
    public func ds_dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        let cell = dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        return cell
    }
    
    public func ds_indexPathForCell(reusableCell: ReusableCell) -> NSIndexPath? {
        guard let cell = reusableCell as? UICollectionViewCell else {
            fatalError("Cell '\(reusableCell)' should be of type UICollectionViewCell.")
        }
        return indexPathForCell(cell)
    }
    
    public func ds_indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath? {
        return indexPathForItemAtPoint(point)
    }
    
    public func ds_numberOfSections() -> Int {
        return numberOfSections()
    }
    
    public func ds_numberOfItemsInSection(section: Int) -> Int {
        return numberOfItemsInSection(section)
    }
    
    public func ds_cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        let cell: UICollectionViewCell? = cellForItemAtIndexPath(indexPath)
        return cell
    }
    
    public func ds_visibleCells() -> [ReusableCell] {
        let cells = visibleCells()
        var reusableCells = [ReusableCell]()
        for cell in cells {
            reusableCells.append(cell)
        }
        return reusableCells
    }
    
    public func ds_indexPathsForVisibleItems() -> [NSIndexPath] {
        return indexPathsForVisibleItems()
    }
    
    public func ds_indexPathsForSelectedItems() -> [NSIndexPath] {
        return indexPathsForSelectedItems() ?? []
    }
}
