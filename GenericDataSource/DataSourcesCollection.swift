//
//  DataSourcesCollection.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/21/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

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

class DataSourcesCollection {

    var mappings: [Mapping] = []
    private var dataSourceToMappings: [DataSourceWrapper: Mapping] = [:]
    
    var dataSources: [DataSource] {
        return mappings.map { $0.dataSource }
    }
    
    // MARK: inserting
    
    func addDataSource(dataSource: DataSource) {
        
        let wrapper = dataSourceWrapperForAddingDataSource(dataSource)
        
        // create the mapping
        let newMapping = createMappingForDataSource(dataSource)
        mappings.append(newMapping)
        dataSourceToMappings[wrapper] = newMapping
        
        // update the mapping
        updateMappings()
    }
    
    func insertDataSource(dataSource: DataSource, atIndex index: Int) {
        
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
        
        // TODO: add it again
        // dataSource.reusableViewDelegate = self
        
        return wrapper
    }

    func removeDataSource(dataSource: DataSource) {
        
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
    
    func containsDataSource(dataSource: DataSource) -> Bool {
        return mappingForDataSource(dataSource) != nil
    }
    
    func indexOfDataSource(dataSource: DataSource) -> Int? {
        guard let mapping = mappingForDataSource(dataSource) else {
            return nil
        }
        return mappings.indexOf(mapping)
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
    
    func numberOfSections() -> Int {
        fatalError("Should be implemented by subclasses")
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        fatalError("Should be implemented by subclasses")
    }
    
    // MARK:- API
    
    func globalIndexPathForLocalIndexPath(indexPath: NSIndexPath, dataSource: DataSource) -> NSIndexPath? {
        
        guard let mapping = mappingForDataSource(dataSource) else {
            return nil
        }
        
        return mapping.globalIndexPathForLocalIndexPath(indexPath)
    }
    
    func collectionViewWrapperFromIndexPath(
        indexPath: NSIndexPath,
        collectionView: CollectionView)
        -> (dataSource: DataSource, localIndexPath: NSIndexPath, wrapperView: TableCollectionCompositionMappingView) {
        updateMappings()
        
        let mapping = mappingForIndexPath(indexPath)
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(indexPath)
        let tableCollectionWrapper = TableCollectionCompositionMappingView(mapping: mapping, view: collectionView)

        return (mapping.dataSource, localIndexPath, tableCollectionWrapper)
    }
    
    
}

extension DataSourcesCollection {
    
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

internal func ==(lhs: DataSourcesCollection.Mapping, rhs: DataSourcesCollection.Mapping) -> Bool {
    return lhs === rhs
}