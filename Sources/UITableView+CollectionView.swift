//
//  UITableView+CollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 4/11/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension UITableView: GeneralCollectionView {
    
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
     Just calls the corresponding method `registerNib(nib, forCellReuseIdentifier: identifier)`.
     */
    public func ds_registerNib(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        register(nib, forCellReuseIdentifier: identifier)
    }

    /**
     Just calls the corresponding method `registerClass(cellClass, forCellReuseIdentifier: identifier)`.
     */
    public func ds_registerClass(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    /**
     Just calls the corresponding method `reloadData`.
     */
    public func ds_reloadData() {
        reloadData()
    }
    
    /**
     It does the following
     ```
     beginUpdates()
     updates?()
     endUpdates()
     completion?(false)
     ```
     */
    public func ds_performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        internal_performBatchUpdates(updates, completion: completion)
    }
    
    /**
     Just calls the corresponding method `insertSections(sections, withRowAnimation: animation)`.
     */
    public func ds_insertSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        insertSections(sections, with: animation)
    }
    
    /**
     Just calls the corresponding method `deleteSections(sections, withRowAnimation: animation)`.
     */
    public func ds_deleteSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        deleteSections(sections, with: animation)
    }
    
    /**
     Just calls the corresponding method `reloadSections(sections, withRowAnimation: animation)`.
     */
    public func ds_reloadSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        reloadSections(sections, with: animation)
    }
    
    /**
     Just calls the corresponding method `moveSection(section, toSection: newSection)`.
     */
    public func ds_moveSection(_ section: Int, toSection newSection: Int) {
        moveSection(section, toSection: newSection)
    }

    /**
     Just calls the corresponding method `insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)`.
     */
    public func ds_insertItemsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        insertRows(at: indexPaths, with: animation)
    }
    
    /**
     Just calls the corresponding method `deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)`.
     */
    public func ds_deleteItemsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        deleteRows(at: indexPaths, with: animation)
    }
    
    /**
     Just calls the corresponding method `reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation)`.
     */
    public func ds_reloadItemsAtIndexPaths(_ indexPaths: [IndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        reloadRows(at: indexPaths, with: animation)
    }
    
    /**
     Just calls the corresponding method `moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)`.
     */
    public func ds_moveItemAtIndexPath(_ indexPath: IndexPath, toIndexPath newIndexPath: IndexPath) {
        moveRow(at: indexPath, to: newIndexPath)
    }
    
    /**
     Just calls the corresponding method `scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition(scrollPosition: scrollPosition), animated: animated)`.
     */
    public func ds_scrollToItemAtIndexPath(_ indexPath: IndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        scrollToRow(at: indexPath, at: UITableViewScrollPosition(scrollPosition: scrollPosition), animated: animated)
    }
    
    /**
     Just calls the corresponding method `selectRowAtIndexPath(indexPath, animated: animated, scrollPosition: UITableViewScrollPosition(scrollPosition: scrollPosition))`.
     */
    public func ds_selectItemAtIndexPath(_ indexPath: IndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        selectRow(at: indexPath, animated: animated, scrollPosition: UITableViewScrollPosition(scrollPosition: scrollPosition))
    }
    
    /**
     Just calls the corresponding method `deselectRowAtIndexPath(indexPath, animated: animated)`.
     */
    public func ds_deselectItemAtIndexPath(_ indexPath: IndexPath, animated: Bool) {
        deselectRow(at: indexPath, animated: animated)
    }
    
    /**
     Just calls the corresponding method `return dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)`.
     */
    public func ds_dequeueReusableCellViewWithIdentifier(_ identifier: String, forIndexPath indexPath: IndexPath) -> ReusableCell {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    /**
     Just calls the corresponding method `return numberOfSections`.
     */
    public func ds_numberOfSections() -> Int {
        return numberOfSections
    }
    
    /**
     Just calls the corresponding method `return numberOfRowsInSection(section)`.
     */
    public func ds_numberOfItemsInSection(_ section: Int) -> Int {
        return numberOfRows(inSection: section)
    }
    
    /**
     Just calls the corresponding method `return indexPathForCell(cell)`.
     */
    public func ds_indexPathForCell(_ reusableCell: ReusableCell) -> IndexPath? {
        guard let cell = reusableCell as? UITableViewCell else {
            fatalError("Cell '\(reusableCell)' should be of type UITableViewCell.")
        }
        return indexPath(for: cell)
    }
    
    /**
     Just calls the corresponding method `return indexPathForRowAtPoint(point)`.
     */
    public func ds_indexPathForItemAtPoint(_ point: CGPoint) -> IndexPath? {
        return indexPathForRow(at: point)
    }
    
    /**
     Just calls the corresponding method `return cellForRowAtIndexPath(indexPath)`.
     */
    public func ds_cellForItemAtIndexPath(_ indexPath: IndexPath) -> ReusableCell? {
        return cellForRow(at: indexPath)
    }
    
    /**
     Just calls the corresponding method `visibleCells`.
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
     Just calls the corresponding method `return indexPathsForVisibleRows ?? []`.
     */
    public func ds_indexPathsForVisibleItems() -> [IndexPath] {
        return indexPathsForVisibleRows ?? []
    }
    
    /**
     Just calls the corresponding method `return indexPathsForSelectedRows ?? []`.
     */
    public func ds_indexPathsForSelectedItems() -> [IndexPath] {
        return indexPathsForSelectedRows ?? []
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
