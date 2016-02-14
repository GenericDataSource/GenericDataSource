//
//  CompositionDataSource.swift
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

public class CompositionDataSource: AbstractDataSource {

    var mappings: [Mapping] = []
    private var dataSourceToMappings: [DataSourceWrapper: Mapping] = [:]

    public var dataSources: [DataSource] {
        return mappings.map { $0.dataSource }
    }

    // MARK: inserting

    public func addDataSource(dataSource: DataSource) {

        let wrapper = dataSourceWrapperForAddingDataSource(dataSource)

        // create the mapping
        let newMapping = createMappingForDataSource(dataSource)
        mappings.append(newMapping)
        dataSourceToMappings[wrapper] = newMapping

        // update the mapping
        updateMappings()
    }

    public func insertDataSource(dataSource: DataSource, atIndex index: Int) {

        assert(index >= 0 && index <= mappings.count, "Invalid index \(index) should be between [0..\(mappings.count)")

        let wrapper = dataSourceWrapperForAddingDataSource(dataSource)

        // create the mapping
        let newMapping = createMappingForDataSource(dataSource)
        mappings.insert(newMapping, atIndex: index)
        dataSourceToMappings[wrapper] = newMapping

        // update the mapping
        updateMappings()
    }

    private func dataSourceWrapperForAddingDataSource(dataSource: DataSource) -> DataSourceWrapper {
        let wrapper = DataSourceWrapper(dataSource: dataSource)
        let existingMapping = dataSourceToMappings[wrapper]
        assert(existingMapping == nil, "Tried to add a data source more than once: \(dataSource)")

        dataSource.reusableViewDelegate = self

        return wrapper
    }

    // MARK: inserting

    public func removeDataSource(dataSource: DataSource) {

        let wrapper = DataSourceWrapper(dataSource: dataSource)
        guard let exsitingMapping = dataSourceToMappings[wrapper] else {
            fatalError("Tried to remove a data source that doesn't exist: \(dataSource)")
        }
        guard let index = mappings.indexOf(exsitingMapping) else {
            fatalError("Tried to remove a data source that doesn't exist: \(dataSource)")
        }

        dataSourceToMappings[wrapper] = nil
        mappings.removeAtIndex(index)

        // update the mapping
        updateMappings()
    }

    // MARK: immutable

    public func containsDataSource(dataSource: DataSource) -> Bool {
        return mappingForDataSource(dataSource) != nil
    }

    public func indexOfDataSource(dataSource: DataSource) -> Int? {
        guard let mapping = mappingForDataSource(dataSource) else {
            return nil
        }
        return mappings.indexOf(mapping)
    }

    public func globalIndexPathForLocalIndexPath(indexPath: NSIndexPath, dataSource: DataSource) -> NSIndexPath? {

        guard let mapping = mappingForDataSource(dataSource) else {
            return nil
        }

        return mapping.globalIndexPathForLocalIndexPath(indexPath)
    }

    internal func mappingForDataSource(dataSource: DataSource) -> Mapping? {
        let wrapper = DataSourceWrapper(dataSource: dataSource)
        let existingMapping = dataSourceToMappings[wrapper]
        return existingMapping
    }

    // MARK:- Subclassing

    internal func createMappingForDataSource(dataSource: DataSource) -> Mapping {
        fatalError("Should be implemented by subclasses")
    }

    internal func updateMappings() {
        fatalError("Should be implemented by subclasses")
    }

    internal func mappingForIndexPath(indexPath: NSIndexPath) -> Mapping {
        fatalError("Should be implemented by subclasses")
    }

    // MARK:- Data Source
    
    // MARK: Cell

    public func tableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

        updateMappings()

        let mapping = mappingForIndexPath(indexPath)
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(indexPath)
        let tableCollectionWrapper = TableCollectionCompositionMappingView(mapping: mapping, view: tableCollectionView)

        return mapping.dataSource.tableCollectionView(tableCollectionWrapper, cellForItemAtIndexPath: localIndexPath)
    }
    
    // MARK: Size
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        updateMappings()
        
        let mapping = mappingForIndexPath(indexPath)
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(indexPath)
        let tableCollectionWrapper = TableCollectionCompositionMappingView(mapping: mapping, view: tableCollectionView)
        
        return mapping.dataSource.tableCollectionView(tableCollectionWrapper, sizeForItemAtIndexPath: localIndexPath)
    }
    
    // MARK: Selection

    public func tableCollectionView(tableCollectionView: TableCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {

        updateMappings()

        let mapping = mappingForIndexPath(indexPath)
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(indexPath)
        let tableCollectionWrapper = TableCollectionCompositionMappingView(mapping: mapping, view: tableCollectionView)

        mapping.dataSource.tableCollectionView(tableCollectionWrapper, didHighlightItemAtIndexPath: localIndexPath)
    }

    public func tableCollectionView(tableCollectionView: TableCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {

        updateMappings()

        let mapping = mappingForIndexPath(indexPath)
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(indexPath)
        let tableCollectionWrapper = TableCollectionCompositionMappingView(mapping: mapping, view: tableCollectionView)

        return mapping.dataSource.tableCollectionView(tableCollectionWrapper, shouldHighlightItemAtIndexPath: localIndexPath)
    }

    public func tableCollectionView(tableCollectionView: TableCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        updateMappings()

        let mapping = mappingForIndexPath(indexPath)
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(indexPath)
        let tableCollectionWrapper = TableCollectionCompositionMappingView(mapping: mapping, view: tableCollectionView)

        mapping.dataSource.tableCollectionView(tableCollectionWrapper, didSelectItemAtIndexPath: localIndexPath)
    }
}

extension CompositionDataSource : DataSourceReusableViewDelegate {

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

extension CompositionDataSource {

    internal class Mapping : Equatable {

        let dataSource: DataSource

        init(dataSource: DataSource) {
            self.dataSource = dataSource
        }

        func localItemForGlobalItem(globalItem: Int) -> Int {
            return globalItem
        }

        func globalItemForLocalItem(localItem: Int) -> Int {
            return localItem
        }

        func localSectionForGlobalSection(globalSection: Int) -> Int {
            return globalSection
        }

        func globalSectionForLocalSection(localSection: Int) -> Int {
            return localSection
        }

        func localIndexPathForGlobalIndexPath(globalIndexPath: NSIndexPath) -> NSIndexPath {
            let localItem = localItemForGlobalItem(globalIndexPath.item)
            let localSection = localSectionForGlobalSection(globalIndexPath.section)
            return NSIndexPath(forItem: localItem, inSection: localSection)
        }

        func globalIndexPathForLocalIndexPath(localIndexPath: NSIndexPath) -> NSIndexPath {
            let globalItem = globalItemForLocalItem(localIndexPath.item)
            let globalSection = globalSectionForLocalSection(localIndexPath.section)
            return NSIndexPath(forItem: globalItem, inSection: globalSection)
        }

        final func localIndexPathesForGlobalIndexPathes(globalIndexPathes: [NSIndexPath]) -> [NSIndexPath] {
            return globalIndexPathes.map(localIndexPathForGlobalIndexPath)
        }

        final func globalIndexPathesForLocalIndexPathes(localIndexPathes: [NSIndexPath]) -> [NSIndexPath] {
            return localIndexPathes.map(globalIndexPathForLocalIndexPath)
        }
    }
}

internal func ==(lhs: CompositionDataSource.Mapping, rhs: CompositionDataSource.Mapping) -> Bool {
    return lhs === rhs
}