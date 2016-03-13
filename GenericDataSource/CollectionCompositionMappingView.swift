//
//  CollectionCompositionMappingView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

internal class CollectionCompositionMappingView : GeneralCollectionView {

    let mapping: DataSourcesCollection.Mapping
    let view : GeneralCollectionView

    init(mapping: DataSourcesCollection.Mapping, view: GeneralCollectionView) {
        self.mapping = mapping
        self.view = view
    }

    var ds_scrollView: UIScrollView { return view.ds_scrollView }

    func ds_localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        return mapping.localIndexPathForGlobalIndexPath(globalIndex)
    }

    func ds_globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        return mapping.globalIndexPathForLocalIndexPath(localIndex)
    }

    func ds_registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        view.ds_registerNib(nib, forCellWithReuseIdentifier: identifier)
    }

    func ds_registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        view.ds_registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }

    func ds_dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        let globalIndex = mapping.globalIndexPathForLocalIndexPath(indexPath)
        return view.ds_dequeueReusableCellViewWithIdentifier(identifier, forIndexPath: globalIndex)
    }

    func ds_numberOfSections() -> Int {
        return view.ds_numberOfSections()
    }

    func ds_numberOfItemsInSection(section: Int) -> Int {
        return view.ds_numberOfItemsInSection(section)
    }

    func ds_indexPathForCell(cell: ReusableCell) -> NSIndexPath? {

        if let globalIndex = view.ds_indexPathForCell(cell) {
            return ds_localIndexPathForGlobalIndexPath(globalIndex)
        }
        return nil
    }

    func ds_indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath? {
        if let globalIndex = view.ds_indexPathForItemAtPoint(point) {
            return ds_localIndexPathForGlobalIndexPath(globalIndex)
        }
        return nil
    }

    func ds_cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        let globalIndex = mapping.globalIndexPathForLocalIndexPath(indexPath)
        return view.ds_cellForItemAtIndexPath(globalIndex)
    }

    func ds_visibleCells() -> [ReusableCell] {
        return view.ds_visibleCells()
    }

    func ds_indexPathsForVisibleItems() -> [NSIndexPath] {
        let globalIndexPaths = view.ds_indexPathsForVisibleItems()
        return mapping.localIndexPathesForGlobalIndexPathes(globalIndexPaths)
    }
    
    func ds_indexPathesForSelectedItems() -> [NSIndexPath] {
        let globalIndexPaths = view.ds_indexPathesForSelectedItems()
        return mapping.localIndexPathesForGlobalIndexPathes(globalIndexPaths)
    }

    func ds_scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        let globalIndex = ds_globalIndexPathForLocalIndexPath(indexPath)
        view.ds_scrollToItemAtIndexPath(globalIndex, atScrollPosition: scrollPosition, animated: animated)
    }

    func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let globalSections = NSMutableIndexSet()
        for section in sections {
            globalSections.addIndex(mapping.globalSectionForLocalSection(section))
        }

        view.ds_insertSections(globalSections, withRowAnimation: animation)
    }

    func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let globalSections = NSMutableIndexSet()
        for section in sections {
            globalSections.addIndex(mapping.globalSectionForLocalSection(section))
        }
        view.ds_deleteSections(globalSections, withRowAnimation: animation)
    }

    func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        let globalSections = NSMutableIndexSet()
        for section in sections {
            globalSections.addIndex(mapping.globalSectionForLocalSection(section))
        }
        view.ds_reloadSections(globalSections, withRowAnimation: animation)
    }

    func ds_moveSection(section: Int, toSection newSection: Int) {
        let globalSection = mapping.globalSectionForLocalSection(section)
        let newGlobalSection = mapping.globalSectionForLocalSection(newSection)
        view.ds_moveSection(globalSection, toSection: newGlobalSection)
    }

    func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        let globalIndexPaths = mapping.globalIndexPathesForLocalIndexPathes(indexPaths)
        view.ds_insertItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        let globalIndexPaths = mapping.globalIndexPathesForLocalIndexPathes(indexPaths)
        view.ds_deleteItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        let globalIndexPaths = mapping.globalIndexPathesForLocalIndexPathes(indexPaths)
        view.ds_reloadItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        let globalIndexPath = mapping.globalIndexPathForLocalIndexPath(indexPath)
        let newGlobalIndexPath = mapping.globalIndexPathForLocalIndexPath(newIndexPath)
        view.ds_moveItemAtIndexPath(globalIndexPath, toIndexPath: newGlobalIndexPath)
    }
    
    func ds_selectItemAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UICollectionViewScrollPosition) {
        let globalIndexPath: NSIndexPath?
        if let indexPath = indexPath {
            globalIndexPath = mapping.globalIndexPathForLocalIndexPath(indexPath)
        } else {
            globalIndexPath = nil
        }
        view.ds_selectItemAtIndexPath(globalIndexPath, animated: animated, scrollPosition: scrollPosition)
    }

    func ds_deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        let globalIndexPath = mapping.globalIndexPathForLocalIndexPath(indexPath)
        view.ds_deselectItemAtIndexPath(globalIndexPath, animated: animated)
    }
    
    func ds_reloadData() {
        view.ds_reloadData()
    }
    
    func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        view.ds_performBatchUpdates(updates, completion: completion)
    }
}
