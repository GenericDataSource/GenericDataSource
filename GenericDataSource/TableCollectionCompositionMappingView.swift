//
//  TableCollectionCompositionMappingView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

internal class TableCollectionCompositionMappingView : TableCollectionView {

    let mapping: DataSourcesCollection.Mapping
    let view : TableCollectionView

    init(mapping: DataSourcesCollection.Mapping, view: TableCollectionView) {
        self.mapping = mapping
        self.view = view
    }

    var scrollView: UIScrollView { return view.scrollView }

    func localIndexPathForGlobalIndexPath(globalIndex: NSIndexPath) -> NSIndexPath {
        return mapping.localIndexPathForGlobalIndexPath(globalIndex)
    }

    func globalIndexPathForLocalIndexPath(localIndex: NSIndexPath) -> NSIndexPath {
        return mapping.globalIndexPathForLocalIndexPath(localIndex)
    }

    func registerNib(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        view.registerNib(nib, forCellWithReuseIdentifier: identifier)
    }

    func registerClass(cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        view.registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCellViewWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> ReusableCell {
        let globalIndex = mapping.globalIndexPathForLocalIndexPath(indexPath)
        return view.dequeueReusableCellViewWithIdentifier(identifier, forIndexPath: globalIndex)
    }

    func totalNumberOfSections() -> Int {
        return view.totalNumberOfSections()
    }

    func numberOfItemsInSection(section: Int) -> Int {
        return view.numberOfItemsInSection(section)
    }

    func indexPathForReusableCell(cell: ReusableCell) -> NSIndexPath? {

        if let globalIndex = indexPathForReusableCell(cell) {
            return mapping.localIndexPathForGlobalIndexPath(globalIndex)
        }
        return nil
    }

    func indexPathForItemAtPoint(point: CGPoint) -> NSIndexPath? {
        if let globalIndex = view.indexPathForItemAtPoint(point) {
            return mapping.localIndexPathForGlobalIndexPath(globalIndex)
        }
        return nil
    }

    func cellForItemAtIndexPath(indexPath: NSIndexPath) -> ReusableCell? {
        let globalIndex = mapping.globalIndexPathForLocalIndexPath(indexPath)
        return view.cellForItemAtIndexPath(globalIndex)
    }

    func visibleCells() -> [ReusableCell] {
        return view.visibleCells()
    }

    func indexPathsForVisibleItems() -> [NSIndexPath] {
        let globalIndexPaths = view.indexPathsForVisibleItems()
        return mapping.localIndexPathesForGlobalIndexPathes(globalIndexPaths)
    }

    func scrollToItemAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, animated: Bool) {
        let globalIndex = globalIndexPathForLocalIndexPath(indexPath)
        view.scrollToItemAtIndexPath(globalIndex, atScrollPosition: scrollPosition, animated: animated)
    }

    func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        let globalSections = NSMutableIndexSet()
        for section in sections {
            globalSections.addIndex(mapping.globalSectionForLocalSection(section))
        }

        view.insertSections(globalSections, withRowAnimation: animation)
    }

    func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        let globalSections = NSMutableIndexSet()
        for section in sections {
            globalSections.addIndex(mapping.globalSectionForLocalSection(section))
        }
        view.deleteSections(globalSections, withRowAnimation: animation)
    }

    func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        let globalSections = NSMutableIndexSet()
        for section in sections {
            globalSections.addIndex(mapping.globalSectionForLocalSection(section))
        }
        view.reloadSections(globalSections, withRowAnimation: animation)
    }

    func moveSection(section: Int, toSection newSection: Int) {
        let globalSection = mapping.globalSectionForLocalSection(section)
        let newGlobalSection = mapping.globalSectionForLocalSection(newSection)
        view.moveSection(globalSection, toSection: newGlobalSection)
    }

    func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        let globalIndexPaths = mapping.globalIndexPathesForLocalIndexPathes(indexPaths)
        view.insertItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        let globalIndexPaths = mapping.globalIndexPathesForLocalIndexPathes(indexPaths)
        view.deleteItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        let globalIndexPaths = mapping.globalIndexPathesForLocalIndexPathes(indexPaths)
        view.reloadItemsAtIndexPaths(globalIndexPaths, withRowAnimation: animation)
    }

    func moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        let globalIndexPath = mapping.globalIndexPathForLocalIndexPath(indexPath)
        let newGlobalIndexPath = mapping.globalIndexPathForLocalIndexPath(newIndexPath)
        view.moveItemAtIndexPath(globalIndexPath, toIndexPath: newGlobalIndexPath)
    }

    func deselectItemAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        let globalIndexPath = mapping.globalIndexPathForLocalIndexPath(indexPath)
        view.deselectItemAtIndexPath(globalIndexPath, animated: animated)
    }
}
