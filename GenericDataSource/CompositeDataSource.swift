//
//  CompositeDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

private class DataSourceWrapper : Hashable {
    let dataSource: DataSource
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    var hashValue: Int {
        return unsafeAddressOf(dataSource).hashValue
    }
}

private func ==(lhs: DataSourceWrapper, rhs: DataSourceWrapper) -> Bool {
    return lhs.dataSource === rhs.dataSource
}

public class CompositeDataSource: AbstractDataSource {
    
    public enum Type {
        case SingleSection
        case MultiSection
    }
    
    private let collection: DataSourcesCollection
    
    public init(type: Type) {
        switch type {
        case .SingleSection:
            collection = SingleSectionDataSourcesCollection()
        case .MultiSection:
            collection = MultiSectionDataSourcesCollection()
        }
        super.init()

        collection.reusableViewDelegate = self
    }

    public var dataSources: [DataSource] {
        return collection.dataSources
    }

    // MARK: inserting

    public func addDataSource(dataSource: DataSource) {
        collection.addDataSource(dataSource)
    }

    public func insertDataSource(dataSource: DataSource, atIndex index: Int) {
        collection.insertDataSource(dataSource, atIndex: index)
    }

    public func removeDataSource(dataSource: DataSource) {
        collection.removeDataSource(dataSource)
    }

    public func containsDataSource(dataSource: DataSource) -> Bool {
        return collection.containsDataSource(dataSource)
    }

    public func indexOfDataSource(dataSource: DataSource) -> Int? {
        return collection.indexOfDataSource(dataSource)
    }

    public func globalIndexPathForLocalIndexPath(indexPath: NSIndexPath, dataSource: DataSource) -> NSIndexPath? {
        return collection.globalIndexPathForLocalIndexPath(indexPath, dataSource: dataSource)
    }

    // MARK:- Data Source
    
    // MARK: Cell
    
    public override func ds_numberOfSections() -> Int {
        return collection.numberOfSections()
    }

    public override func ds_numberOfItems(inSection section: Int) -> Int {
        return collection.numberOfItems(inSection: section)
    }

    public override func ds_collectionView(collectionView: CollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, cellForItemAtIndexPath: mapping.localIndexPath)
    }

    // MARK: Size
    
    public override func ds_collectionView(collectionView: CollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, sizeForItemAtIndexPath: mapping.localIndexPath)
    }
    
    // MARK: Selection

    public override func ds_collectionView(collectionView: CollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {

        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        mapping.dataSource.ds_collectionView(mapping.wrapperView, didHighlightItemAtIndexPath: mapping.localIndexPath)
    }

    public override func ds_collectionView(collectionView: CollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {

        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, shouldHighlightItemAtIndexPath: mapping.localIndexPath)
    }

    public override func ds_collectionView(collectionView: CollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        mapping.dataSource.ds_collectionView(mapping.wrapperView, didSelectItemAtIndexPath: mapping.localIndexPath)
    }
}

extension CompositeDataSource : DataSourceReusableViewDelegate {

    public func ds_reloadData() {
        ds_reusableViewDelegate?.ds_reloadData()
    }

    public func ds_performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        ds_reusableViewDelegate?.ds_performBatchUpdates(updates, completion: completion)
    }

    public func ds_insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        ds_reusableViewDelegate?.ds_insertSections(sections, withRowAnimation: animation)
    }

    public func ds_deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        ds_reusableViewDelegate?.ds_deleteSections(sections, withRowAnimation: animation)
    }

    public func ds_reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation) {
        ds_reusableViewDelegate?.ds_reloadSections(sections, withRowAnimation: animation)
    }

    public func ds_moveSection(section: Int, toSection newSection: Int) {
        ds_reusableViewDelegate?.ds_moveSection(section, toSection: newSection)
    }

    public func ds_insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        ds_reusableViewDelegate?.ds_insertItemsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }

    public func ds_deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        ds_reusableViewDelegate?.ds_deleteItemsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }

    public func ds_reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation) {
        ds_reusableViewDelegate?.ds_reloadItemsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }

    public func ds_moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        ds_reusableViewDelegate?.ds_moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }
}

