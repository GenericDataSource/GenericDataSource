//
//  CompositeReusableViewDelegate.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/21/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

class CompositeReusableViewDelegate : DataSourceReusableViewDelegate {
    
    weak var parentDataSource: CompositeDataSource?
    
    weak var dataSource: DataSource?
    
    var delegate: DataSourceReusableViewDelegate? {
        return parentDataSource?.ds_reusableViewDelegate
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
        guard let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_scrollToItemAtIndexPath(globalIndexPath, atScrollPosition: scrollPosition, animated: animated)
    }
    
    func ds_reloadData() {
        delegate?.ds_reloadData()
    }
    
    func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        delegate?.ds_performBatchUpdates(updates, completion: completion)
    }
    
    func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        guard let globalSections = globalSectionSetForLocalSectionSet(sections) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_insertSections(globalSections, withRowAnimation: animation)
    }
    
    func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        guard let globalSections = globalSectionSetForLocalSectionSet(sections) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_deleteSections(globalSections, withRowAnimation: animation)
    }
    
    func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        guard let globalSections = globalSectionSetForLocalSectionSet(sections) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_reloadSections(globalSections, withRowAnimation: animation)
    }
    
    func ds_moveSection(section: Int, toSection newSection: Int) {
        guard let globalSection = globalSectionForLocalSection(section),
            let globalNewSection = globalSectionForLocalSection(newSection) else {
            return // does nothing, since not configured
        }

        delegate?.ds_moveSection(globalSection, toSection: globalNewSection)
    }
    
    func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        guard let globalIndexPaths = globalIndexPathsForLocalIndexPaths(indexPaths) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_insertItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }
    
    func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        guard let globalIndexPaths = globalIndexPathsForLocalIndexPaths(indexPaths) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_deleteItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }
    
    func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        guard let globalIndexPaths = globalIndexPathsForLocalIndexPaths(indexPaths) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_reloadItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        guard let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath),
            let globalNewIndexPath = globalIndexPathForLocalIndexPath(indexPath) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_moveItemAtIndexPath(globalIndexPath, toIndexPath: globalNewIndexPath)
    }
    
    func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        let globalIndexPath: NSIndexPath?
        if let indexPath = indexPath {
            guard let theGlobalIndexPath = globalIndexPathForLocalIndexPath(indexPath) else {
                return // does nothing, since not configured
            }
            globalIndexPath = theGlobalIndexPath
        } else {
            globalIndexPath = nil
        }
        
        delegate?.ds_selectItemAtIndexPath(globalIndexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        guard let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath) else {
            return // does nothing, since not configured
        }
        
        delegate?.ds_deselectItemAtIndexPath(globalIndexPath, animated: animated)
    }
    
    // MARK:- Returning something
    
    var ds_scrollView: UIScrollView {
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate.")
        }
        return delegate.ds_scrollView
    }
    
    func ds_localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        guard let dataSource = dataSource else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil dataSource.")
        }
        guard let parentDataSource = parentDataSource else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil parentDataSource.")
        }
        return parentDataSource.localIndexPathForGlobalIndexPath(globalIndex, dataSource: dataSource)
    }
    
    func ds_globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        guard let dataSource = dataSource else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil dataSource.")
        }
        guard let parentDataSource = parentDataSource else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil parentDataSource.")
        }
        return parentDataSource.globalIndexPathForLocalIndexPath(localIndex, dataSource: dataSource)
    }

    func ds_dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        guard let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath) else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil parentDataSource or dataSource.")
        }
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate.")
        }

        return delegate.ds_dequeueReusableCellViewWithIdentifier(identifier, forIndexPath: globalIndexPath)
    }
    
    func ds_numberOfSections() -> Int {
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate.")
        }
        return delegate.ds_numberOfSections()
    }
    
    func ds_numberOfItemsInSection(section: Int) -> Int {
        guard let globalSection = globalSectionForLocalSection(section) else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil parentDataSource or dataSource.")
        }
        guard let delegate = delegate else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil delegate.")
        }
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
        guard let globalIndexPath = globalIndexPathForLocalIndexPath(indexPath) else {
            fatalError("Couldn't call \(__FUNCTION__) of \(self) with a nil parentDataSource or dataSource.")
        }
        return delegate?.ds_cellForItemAtIndexPath(globalIndexPath)
    }

    // MARK:- Private
    
    private func localIndexPathForGlobalIndexPath(globalIndexPath: NSIndexPath) -> NSIndexPath? {
        guard let parentDataSource = parentDataSource, dataSource = dataSource else {
            return nil
        }
        return parentDataSource.localIndexPathForGlobalIndexPath(globalIndexPath, dataSource: dataSource)
    }
    
    private func localIndexPathsForGlobalIndexPaths(globalIndexPaths: [NSIndexPath]) -> [NSIndexPath]? {
        guard let parentDataSource = parentDataSource, dataSource = dataSource else {
            return nil
        }
        return globalIndexPaths.map { parentDataSource.localIndexPathForGlobalIndexPath($0, dataSource: dataSource) }
    }
 
    private func globalIndexPathForLocalIndexPath(localIndexPath: NSIndexPath) -> NSIndexPath? {
        guard let parentDataSource = parentDataSource, dataSource = dataSource else {
            return nil
        }
        return parentDataSource.globalIndexPathForLocalIndexPath(localIndexPath, dataSource: dataSource)
    }

    private func globalIndexPathsForLocalIndexPaths(localIndexPaths: [NSIndexPath]) -> [NSIndexPath]? {
        guard let parentDataSource = parentDataSource, dataSource = dataSource else {
            return nil
        }
        return localIndexPaths.map { parentDataSource.globalIndexPathForLocalIndexPath($0, dataSource: dataSource) }
    }
    
    private func globalSectionForLocalSection(localSection: Int) -> Int? {
        guard let parentDataSource = parentDataSource, dataSource = dataSource else {
            return nil
        }
        return parentDataSource.globalSectionForLocalSection(localSection, dataSource: dataSource)
    }
    
    private func globalSectionSetForLocalSectionSet(localSections: NSIndexSet) -> NSIndexSet? {
        guard let parentDataSource = parentDataSource, dataSource = dataSource else {
            return nil
        }
        
        let globalSections = NSMutableIndexSet()
        for section in localSections {
            let globalSection = parentDataSource.globalSectionForLocalSection(section, dataSource: dataSource)
            globalSections.addIndex(globalSection)
        }
        return globalSections
    }
}
