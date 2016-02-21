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
    
    public override func numberOfSections() -> Int {
        return collection.numberOfSections()
    }

    public override func numberOfItems(inSection section: Int) -> Int {
        return collection.numberOfItems(inSection: section)
    }

    public override func tableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

        let mapping = collection.tableCollectionViewWrapperFromIndexPath(indexPath, tableCollectionView: tableCollectionView)
        return mapping.dataSource.tableCollectionView(mapping.wrapperView, cellForItemAtIndexPath: mapping.localIndexPath)
    }

    // MARK: Size
    
    public override func tableCollectionView(tableCollectionView: TableCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let mapping = collection.tableCollectionViewWrapperFromIndexPath(indexPath, tableCollectionView: tableCollectionView)
        return mapping.dataSource.tableCollectionView(mapping.wrapperView, sizeForItemAtIndexPath: mapping.localIndexPath)
    }
    
    // MARK: Selection

    public override func tableCollectionView(tableCollectionView: TableCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {

        let mapping = collection.tableCollectionViewWrapperFromIndexPath(indexPath, tableCollectionView: tableCollectionView)
        mapping.dataSource.tableCollectionView(mapping.wrapperView, didHighlightItemAtIndexPath: mapping.localIndexPath)
    }

    public override func tableCollectionView(tableCollectionView: TableCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {

        let mapping = collection.tableCollectionViewWrapperFromIndexPath(indexPath, tableCollectionView: tableCollectionView)
        return mapping.dataSource.tableCollectionView(mapping.wrapperView, shouldHighlightItemAtIndexPath: mapping.localIndexPath)
    }

    public override func tableCollectionView(tableCollectionView: TableCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        let mapping = collection.tableCollectionViewWrapperFromIndexPath(indexPath, tableCollectionView: tableCollectionView)
        mapping.dataSource.tableCollectionView(mapping.wrapperView, didSelectItemAtIndexPath: mapping.localIndexPath)
    }
}

extension CompositeDataSource : DataSourceReusableViewDelegate {

    public func reloadData() {
        reusableViewDelegate?.reloadData()
    }

    public func performBatchUpdates(updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        reusableViewDelegate?.performBatchUpdates(updates, completion: completion)
    }

    public func insertSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        reusableViewDelegate?.insertSections(sections, withRowAnimation: animation)
    }

    public func deleteSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        reusableViewDelegate?.deleteSections(sections, withRowAnimation: animation)
    }

    public func reloadSections(sections: NSIndexSet, withRowAnimation animation: UITableViewRowAnimation?) {
        reusableViewDelegate?.reloadSections(sections, withRowAnimation: animation)
    }

    public func moveSection(section: Int, toSection newSection: Int) {
        reusableViewDelegate?.moveSection(section, toSection: newSection)
    }

    public func insertItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        reusableViewDelegate?.insertItemsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }

    public func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        reusableViewDelegate?.deleteItemsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }

    public func reloadItemsAtIndexPaths(indexPaths: [NSIndexPath], withRowAnimation animation: UITableViewRowAnimation?) {
        reusableViewDelegate?.reloadItemsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }

    public func moveItemAtIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        reusableViewDelegate?.moveItemAtIndexPath(indexPath, toIndexPath: newIndexPath)
    }
}

