//
//  UICollectionView+CollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 4/11/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension UICollectionView: GeneralCollectionView {
    
    /**
     Represents the underlying scroll view. Use this method if you want to get the
     `UICollectionView`/`UITableView` itself not a wrapper.
     So, if you have for example an instance like the following
     ```
     let generalCollectionView: GeneralCollectionView = <...>
     
     // Not Recommented, can result crashes if there is a CompositeDataSource.
     let underlyingTableView = generalCollectionView as! UITableView
     
     // Recommended, safer
     let underlyingTableView = generalCollectionView.ds_scrollView as! UITableView
     ```
     The later can result a crash if the scroll view is a UICollectionView not a UITableView.
     
     */
    public var ds_scrollView: UIScrollView { return self }
    
    /**
     Just calls the corresponding method `registerNib(nib, forCellWithReuseIdentifier: identifier)`.
     */
    public func ds_registerNib(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    /**
     Just calls the corresponding method `registerClass(cellClass, forCellWithReuseIdentifier: identifier)`.
     */
    public func ds_registerClass(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    /**
     Just calls the corresponding method `reloadData()`.
     */
    public func ds_reloadData() {
        reloadData()
    }
    
    /**
     Just calls the corresponding method `performBatchUpdates(updates, completion: completion)`.
     */
    public func ds_performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        internal_performBatchUpdates(updates, completion: completion)
    }
    
    /**
     Just calls the corresponding method `insertSections(sections)`.
     */
    public func ds_insertSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        insertSections(sections)
    }
    
    /**
     Just calls the corresponding method `deleteSections(sections)`.
     */
    public func ds_deleteSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        deleteSections(sections)
    }
    
    /**
     Just calls the corresponding method `reloadSections(sections)`.
     */
    public func ds_reloadSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        reloadSections(sections)
    }
    
    /**
     Just calls the corresponding method `moveSection(section, toSection: newSection)`.
     */
    public func ds_moveSection(_ section: Int, toSection newSection: Int) {
        moveSection(section, toSection: newSection)
    }
    
    /**
     Just calls the corresponding method `insertItemsAtIndexPaths(indexPaths)`.
     */
    public func ds_insertItemsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        insertItems(at: indexPaths)
    }
    
    /**
     Just calls the corresponding method `deleteItemsAtIndexPaths(indexPaths)`.
     */
    public func ds_deleteItemsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        deleteItems(at: indexPaths)
    }
    
    /**
     Just calls the corresponding method `reloadItemsAtIndexPaths(indexPaths)`.
     */
    public func ds_reloadItemsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        reloadItems(at: indexPaths)
    }
    
    /**
     Just calls the corresponding method `moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath)`.
     */
    public func ds_moveItemAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
        moveItem(at: indexPath, to: newIndexPath)
    }
    
    /**
     Just calls the corresponding method `scrollToItemAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: animated)`.
     */
    public func ds_scrollToItemAtIndexPath(_ indexPath: IndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }
    
    /**
     Just calls the corresponding method `selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: scrollPosition)`.
     */
    public func ds_selectItemAtIndexPath(_ indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    /**
     Just calls the corresponding method `deselectItemAtIndexPath(indexPath, animated: animated)`.
     */
    public func ds_deselectItemAtIndexPath(_ indexPath: IndexPath, animated: Bool) {
        deselectItem(at: indexPath, animated: animated)
    }
    
    /**
     Just calls the corresponding method `return dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)`.
     */
    public func ds_dequeueReusableCellViewWithIdentifier(_ identifier: String, forIndexPath indexPath: IndexPath) -> ReusableCell {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    /**
     Just calls the corresponding method `return indexPathForCell(cell)`.
     */
    public func ds_indexPathForCell(_ reusableCell: ReusableCell) -> IndexPath? {
        guard let cell = reusableCell as? UICollectionViewCell else {
            fatalError("Cell '\(reusableCell)' should be of type UICollectionViewCell.")
        }
        return indexPath(for: cell)
    }
    
    /**
     Just calls the corresponding method `return indexPathForItemAtPoint(point)`.
     */
    public func ds_indexPathForItemAtPoint(_ point: CGPoint) -> IndexPath? {
        return indexPathForItem(at: point)
    }
    
    /**
     Just calls the corresponding method `return numberOfSections()`.
     */
    public func ds_numberOfSections() -> Int {
        return numberOfSections
    }
    
    /**
     Just calls the corresponding method `return numberOfItemsInSection(section)`.
     */
    public func ds_numberOfItemsInSection(_ section: Int) -> Int {
        return numberOfItems(inSection: section)
    }
    
    /**
     Just calls the corresponding method `return cellForItemAtIndexPath(indexPath)`.
     */
    public func ds_cellForItemAtIndexPath(_ indexPath: IndexPath) -> ReusableCell? {
        return cellForItem(at: indexPath)
    }
    
    /**
     Just calls the corresponding method `visibleCells()`.
     */
    public func ds_visibleCells() -> [ReusableCell] {
        let cells = visibleCells
        var reusableCells = [ReusableCell]()
        for cell in cells {
            reusableCells.append(cell)
        }
        return reusableCells
    }
    
    /**
     Just calls the corresponding method `return indexPathsForVisibleItems()`.
     */
    public func ds_indexPathsForVisibleItems() -> [IndexPath] {
        return indexPathsForVisibleItems
    }
    
    /**
     Just calls the corresponding method `return indexPathsForSelectedItems() ?? []`.
     */
    public func ds_indexPathsForSelectedItems() -> [IndexPath] {
        return indexPathsForSelectedItems ?? []
    }
    
    /**
     Always returns the same value passed.
     */
    public func ds_localIndexPathForGlobalIndexPath(_ globalIndex: IndexPath) -> IndexPath {
        return globalIndex
    }
    
    /**
     Always returns the same value passed.
     */
    public func ds_globalIndexPathForLocalIndexPath(_ localIndex: IndexPath) -> IndexPath {
        return localIndex
    }

    /**
     Always returns the same value passed.
     */
    public func ds_globalSectionForLocalSection(_ localSection: Int) -> Int {
        return localSection
    }
}
