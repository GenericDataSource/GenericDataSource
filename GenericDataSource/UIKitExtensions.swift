//
//  UIKitExtensions.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension UITableViewCell : ReusableCell { }

extension UICollectionViewCell : ReusableCell { }

extension UITableView : TableCollectionView {
    
    public var scrollView: UIScrollView { return self }

    public func localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        return globalIndex
    }

    public func globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        return localIndex
    }

    public func registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        registerNib(nib, forCellReuseIdentifier: identifier)
    }

    public func registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        registerClass(cellClass, forCellReuseIdentifier: identifier)
    }

    public func dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        let cell = dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        return cell
    }

    public func totalNumberOfSections() -> Int {
        return numberOfSections
    }

    public func numberOfItemsInSection(section: Int) -> Int {
        return numberOfRowsInSection(section)
    }

    public func indexPathForReusableCell(cell: ReusableCell) -> NSIndexPath? {
        if let cell = cell as? UITableViewCell {
            return indexPathForCell(cell)
        }
        return nil
    }

    public func indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath? {
        return indexPathForRowAtPoint(point)
    }

    public func cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        return cellForRowAtIndexPath(indexPath)
    }

    public func visibleCells() -> [ReusableCell] {
        let cells: [UITableViewCell] = visibleCells()
        return cells
    }

    public func indexPathsForVisibleItems() -> [NSIndexPath] {
        return indexPathsForVisibleRows ?? []
    }

    public func scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        let position: UITableViewScrollPosition
        if scrollPosition.contains(.Top) {
            position = .Top
        } else if scrollPosition.contains(.Bottom) {
            position = .Bottom
        } else if scrollPosition.contains(.CenteredVertically) {
            position = .Middle
        } else {
            position = .None
        }
        scrollToRowAtIndexPath(indexPath, atScrollPosition: position, animated: animated)
    }

    public func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        if let animation = animation {
            insertSections(sections, withRowAnimation: animation)
        }
    }

    public func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        if let animation = animation {
            deleteSections(sections, withRowAnimation: animation)
        }
    }

    public func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        if let animation = animation {
            reloadSections(sections, withRowAnimation: animation)
        }
    }

    public func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        if let animation = animation {
            insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        }
    }

    public func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        if let animation = animation {
            deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        }
    }

    public func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        if let animation = animation {
            reloadRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        }
    }

    public func moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }

    public func deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        deselectRowAtIndexPath(indexPath, animated: animated)
    }
}

extension UICollectionView : TableCollectionView {
    
    public var scrollView: UIScrollView { return self }

    public func localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        return globalIndex
    }

    public func globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        return localIndex
    }

    public func dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        let cell = dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        return cell
    }
    public func indexPathForReusableCell(cell: ReusableCell) -> NSIndexPath? {
        if let cell = cell as? UICollectionViewCell {
            return indexPathForCell(cell)
        }
        return nil
    }

    public func totalNumberOfSections() -> Int {
        return numberOfSections()
    }

    public func cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        let cell: UICollectionViewCell? = cellForItemAtIndexPath(indexPath)
        return cell
    }

    public func visibleCells() -> [ReusableCell] {
        let cells: [UICollectionViewCell] = visibleCells()
        return cells
    }

    public func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        insertSections(sections)
    }

    public func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        deleteSections(sections)
    }

    public func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        reloadSections(sections)
    }

    public func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        insertItemsAtIndexPaths(indexPaths)
    }

    public func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        deleteItemsAtIndexPaths(indexPaths)
    }

    public func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        reloadItemsAtIndexPaths(indexPaths)
    }
}