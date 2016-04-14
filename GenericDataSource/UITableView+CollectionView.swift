//
//  UITableView+CollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 4/11/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension UITableView: GeneralCollectionView {
    
    public func ds_registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        registerNib(nib, forCellReuseIdentifier: identifier)
    }
    
    public func ds_registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        registerClass(cellClass, forCellReuseIdentifier: identifier)
    }
    
    public func ds_reloadData() {
        reloadData()
    }
    
    public func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        internal_performBatchUpdates(updates, completion: completion)
    }
    
    public func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        insertSections(sections, withRowAnimation: animation)
    }
    
    public func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        deleteSections(sections, withRowAnimation: animation)
    }
    
    public func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        reloadSections(sections, withRowAnimation: animation)
    }
    
    public func ds_moveSection(section: Int, toSection newSection: Int) {
        moveSection(section, toSection: newSection)
    }

    public func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    public func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    public func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    public func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }
    
    public func ds_scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition(scrollPosition: scrollPosition), animated: animated)
    }
    
    public func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        selectRowAtIndexPath(indexPath, animated: animated, scrollPosition: UITableViewScrollPosition(scrollPosition: scrollPosition))
    }
    
    public func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        deselectRowAtIndexPath(indexPath, animated: animated)
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
        let cell = dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        return cell
    }
    
    public func ds_numberOfSections() -> Int {
        return numberOfSections
    }
    
    public func ds_numberOfItemsInSection(section: Int) -> Int {
        return numberOfRowsInSection(section)
    }
    
    public func ds_indexPathForCell(reusableCell: ReusableCell) -> NSIndexPath? {
        guard let cell = reusableCell as? UITableViewCell else {
            fatalError("Cell '\(reusableCell)' should be of type UITableViewCell.")
        }
        return indexPathForCell(cell)
    }
    
    public func ds_indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath? {
        return indexPathForRowAtPoint(point)
    }
    
    public func ds_cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        return cellForRowAtIndexPath(indexPath)
    }
    
    public func ds_visibleCells() -> [ReusableCell] {
        let cells = visibleCells
        var reusableCells = [ReusableCell]()
        for cell in cells {
            reusableCells.append(cell)
        }
        return reusableCells
    }
    
    public func ds_indexPathsForVisibleItems() -> [NSIndexPath] {
        return indexPathsForVisibleRows ?? []
    }
    
    public func ds_indexPathsForSelectedItems() -> [NSIndexPath] {
        return indexPathsForSelectedRows ?? []
    }
}
