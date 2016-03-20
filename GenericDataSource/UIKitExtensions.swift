//
//  UIKitExtensions.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension UITableViewScrollPosition {
    init(scrollPosition: UICollectionViewScrollPosition) {
        if scrollPosition.contains(.Top) {
            self = .Top
        } else if scrollPosition.contains(.Bottom) {
            self = .Bottom
        } else if scrollPosition.contains(.CenteredVertically) {
            self = .Middle
        } else {
            self = .None
        }
    }
}

extension UITableView {
    
    public func ds_useDataSource(dataSource: AbstractDataSource) {
        self.dataSource = dataSource
        self.delegate = dataSource
        dataSource.ds_reusableViewDelegate = self
    }
}


extension UICollectionView {
    
    public func ds_useDataSource(dataSource: AbstractDataSource) {
        self.dataSource = dataSource
        self.delegate = dataSource
        dataSource.ds_reusableViewDelegate = self
    }
}

extension UITableViewCell : ReusableCell { }

extension UICollectionViewCell : ReusableCell { }

protocol BatchUpdater: class {
    
    func actualPerformBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?)
}

extension UICollectionView : BatchUpdater {
    func actualPerformBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        performBatchUpdates(updates, completion: completion)
    }
}

extension UITableView : BatchUpdater {
    func actualPerformBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        beginUpdates()
        updates?()
        endUpdates()
        completion?(false)
    }
}

private class CompletionBlock {
    let block: Bool -> Void
    init(block: Bool -> Void) { self.block = block }
}

private struct AssociatedKeys {
    static var performingBatchUpdates = "performingBatchUpdates"
    static var completionBlocks = "completionBlocks"
}

extension GeneralCollectionView where Self : BatchUpdater {

    private var performingBatchUpdates: Bool {
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKeys.performingBatchUpdates) as? NSNumber
            return value?.boolValue ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.performingBatchUpdates, NSNumber(bool: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var completionBlocks: [CompletionBlock] {
        get {
            let value = objc_getAssociatedObject(self, &AssociatedKeys.completionBlocks) as? [CompletionBlock]
            return value ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.completionBlocks, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func internal_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        guard !performingBatchUpdates else {
            if let completion = completion {
                var blocks = completionBlocks
                blocks.append(CompletionBlock(block: completion))
                completionBlocks = blocks
            }
            updates?()
            return
        }
        
        performingBatchUpdates = true
        actualPerformBatchUpdates(updates) { [weak self] completed in
            self?.performingBatchUpdates = false
            completion?(completed)
            for block in self?.completionBlocks ?? [] {
                block.block(completed)
            }
            self?.completionBlocks = []
        }
    }
}

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

    public func ds_indexPathesForSelectedItems() -> [NSIndexPath] {
        return indexPathsForSelectedRows ?? []
    }
}

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
    
    public func ds_indexPathesForSelectedItems() -> [NSIndexPath] {
        return indexPathsForSelectedItems() ?? []
    }
}