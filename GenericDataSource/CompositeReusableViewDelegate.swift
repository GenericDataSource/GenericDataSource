//
//  CompositeReusableViewDelegate.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/21/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

class CompositeReusableViewDelegate : DataSourceReusableViewDelegate {
    
    unowned var parentDataSource: CompositeDataSource

    unowned var dataSource: DataSource

    var delegate: DataSourceReusableViewDelegate? {
        return parentDataSource.ds_reusableViewDelegate
    }
    
    init(dataSource: DataSource, parentDataSource: CompositeDataSource) {
        self.dataSource = dataSource
        self.parentDataSource = parentDataSource
    }
    
    func ds_registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        delegate?.ds_registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func ds_registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        delegate?.ds_registerNib(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func ds_scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        delegate?.ds_scrollToItemAtIndexPath(globalIndexPath, atScrollPosition: scrollPosition, animated: animated)
    }
    
    func ds_reloadData() {
        delegate?.ds_reloadData()
    }
    
    func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        delegate?.ds_performBatchUpdates(updates, completion: completion)
    }
    
    func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let globalSections = globalSectionSetForLocalSectionSet(sections)
        delegate?.ds_insertSections(globalSections, withRowAnimation: animation)
    }
    
    func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let globalSections = globalSectionSetForLocalSectionSet(sections)
        delegate?.ds_deleteSections(globalSections, withRowAnimation: animation)
    }
    
    func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let globalSections = globalSectionSetForLocalSectionSet(sections)
        delegate?.ds_reloadSections(globalSections, withRowAnimation: animation)
    }
    
    func ds_moveSection(section: Int, toSection newSection: Int) {
        let globalSection = globalSectionForLocalSection(section)
        let globalNewSection = globalSectionForLocalSection(newSection)
        delegate?.ds_moveSection(globalSection, toSection: globalNewSection)
    }
    
    func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        let globalIndexPaths = globalIndexPathsForLocalIndexPaths(indexPaths)
        delegate?.ds_insertItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }
    
    func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        let globalIndexPaths = globalIndexPathsForLocalIndexPaths(indexPaths)
        delegate?.ds_deleteItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }
    
    func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        let globalIndexPaths = globalIndexPathsForLocalIndexPaths(indexPaths)
        delegate?.ds_reloadItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        let globalNewIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        
        delegate?.ds_moveItemAtIndexPath(globalIndexPath, toIndexPath: globalNewIndexPath)
    }
    
    func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        let globalIndexPath: NSIndexPath?
        if let indexPath = indexPath {
            globalIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        } else {
            globalIndexPath = nil
        }
        
        delegate?.ds_selectItemAtIndexPath(globalIndexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        delegate?.ds_deselectItemAtIndexPath(globalIndexPath, animated: animated)
    }
    
    // MARK:- Returning something
    
    var ds_scrollView: UIScrollView {
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate. This is usually because you didn't set your UITableView/UICollection to be ds_reusableViewDelegate for the GenericDataSource.")
        }
        return delegate.ds_scrollView
    }
    
    func ds_localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        return parentDataSource.localIndexPathForGlobalIndexPath(globalIndex, dataSource: dataSource)
    }
    
    func ds_globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        return parentDataSource.globalIndexPathForLocalIndexPath(localIndex, dataSource: dataSource)
    }

    func ds_dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate. This is usually because you didn't set your UITableView/UICollection to be ds_reusableViewDelegate for the GenericDataSource.")
        }

        let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        return delegate.ds_dequeueReusableCellViewWithIdentifier(identifier, forIndexPath: globalIndexPath)
    }
    
    func ds_numberOfSections() -> Int {
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate. This is usually because you didn't set your UITableView/UICollection to be ds_reusableViewDelegate for the GenericDataSource.")
        }
        return delegate.ds_numberOfSections()
    }
    
    func ds_numberOfItemsInSection(section: Int) -> Int {
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate. This is usually because you didn't set your UITableView/UICollection to be ds_reusableViewDelegate for the GenericDataSource.")
        }
        let globalSection = globalSectionForLocalSection(section)
        return delegate.ds_numberOfItemsInSection(globalSection)
    }
    
    func ds_indexPathForReusableCell(cell: ReusableCell) -> NSIndexPath? {
        if let indexPath = delegate?.ds_indexPathForReusableCell(cell) {
            return localIndexPathForGlobalIndexPath(indexPath)
        }
        return nil
    }

    func ds_indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath? {
        if let indexPath = delegate?.ds_indexPathForItemAtPoint(point) {
            return localIndexPathForGlobalIndexPath(indexPath)
        }
        return nil
    }
    
    func ds_indexPathsForVisibleItems() -> [NSIndexPath] {
        if let indexPaths = delegate?.ds_indexPathsForVisibleItems() {
            return localIndexPathsForGlobalIndexPaths(indexPaths) ?? []
        }
        return []
    }
    
    func ds_indexPathesForSelectedItems() -> [NSIndexPath] {
        if let indexPaths = delegate?.ds_indexPathesForSelectedItems() {
            return localIndexPathsForGlobalIndexPaths(indexPaths) ?? []
        }
        return []
    }
    
    func ds_visibleCells() -> [ReusableCell] {
        return delegate?.ds_visibleCells() ?? []
    }
    
    func ds_cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath)
        return delegate?.ds_cellForItemAtIndexPath(globalIndexPath)
    }

    // MARK:- Private
    
    private func localIndexPathForGlobalIndexPath(globalIndexPath: NSIndexPath) -> NSIndexPath {
        return parentDataSource.localIndexPathForGlobalIndexPath(globalIndexPath, dataSource: dataSource)
    }
    
    private func localIndexPathsForGlobalIndexPaths(globalIndexPaths: [NSIndexPath]) -> [NSIndexPath] {
        return globalIndexPaths.map { parentDataSource.localIndexPathForGlobalIndexPath($0, dataSource: dataSource) }
    }
 
    private func globalIndexPathForLocalIndexPath(localIndexPath: NSIndexPath) -> NSIndexPath {
        return parentDataSource.globalIndexPathForLocalIndexPath(localIndexPath, dataSource: dataSource)
    }

    private func globalIndexPathsForLocalIndexPaths(localIndexPaths: [NSIndexPath]) -> [NSIndexPath] {
        return localIndexPaths.map { parentDataSource.globalIndexPathForLocalIndexPath($0, dataSource: dataSource) }
    }

    private func globalSectionForLocalSection(localSection: Int) -> Int {
        return parentDataSource.globalSectionForLocalSection(localSection, dataSource: dataSource)
    }

    private func globalSectionSetForLocalSectionSet(localSections: NSIndexSet) -> NSIndexSet {

        let globalSections = NSMutableIndexSet()
        for section in localSections {
            let globalSection = parentDataSource.globalSectionForLocalSection(section, dataSource: dataSource)
            globalSections.addIndex(globalSection)
        }
        return globalSections
    }
}
