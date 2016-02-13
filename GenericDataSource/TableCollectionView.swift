//
//  TableCollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation


public protocol ReusableCell { }

extension UITableView : DataSourceReusableViewDelegate {
    
    public func performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        beginUpdates()
        updates?()
        endUpdates()
        completion?(false)
    }
}

extension UICollectionView : DataSourceReusableViewDelegate { }

public protocol TableCollectionView {
    
    var innerScrollView: UIScrollView { get }
    
    func localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath
    func globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath
    
    func registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String)
    func registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
    func dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell
    
    func totalNumberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    
    func indexPathForReusableCell(cell: ReusableCell) -> NSIndexPath?
    func indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath?
    
    func cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell?
    func visibleCells() -> [ReusableCell]
    func indexPathsForVisibleItems() -> [NSIndexPath]
    
    func scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool)
    
    func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?)
    func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?)
    func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?)
    func moveSection(section: Int, toSection newSection: Int)
    
    func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?)
    func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?)
    func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?)
    func moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath)
    
    func deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool)
}