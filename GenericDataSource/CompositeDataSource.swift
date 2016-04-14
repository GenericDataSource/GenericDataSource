//
//  CompositeDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

public class CompositeDataSource: AbstractDataSource {
    
    public enum Type {
        case SingleSection
        case MultiSection
    }

    private var collection: DataSourcesCollection!
    
    public init(type: Type) {
        super.init()
        
        switch type {
        case .SingleSection:
            collection = SingleSectionDataSourcesCollection(parentDataSource: self)
        case .MultiSection:
            collection = MultiSectionDataSourcesCollection(parentDataSource: self)
        }
    }

    public var dataSources: [DataSource] {
        return collection.dataSources
    }
    
    public override func respondsToSelector(selector: Selector) -> Bool {

        if sizeSelectors.contains(selector) {
            return ds_shouldConsumeItemSizeDelegateCalls()
        }
        
        return super.respondsToSelector(selector)
    }

    // MARK: Children DataSources

    public func addDataSource(dataSource: DataSource) {
        collection.addDataSource(dataSource)
    }

    public func insertDataSource(dataSource: DataSource, atIndex index: Int) {
        collection.insertDataSource(dataSource, atIndex: index)
    }

    public func removeDataSource(dataSource: DataSource) {
        collection.removeDataSource(dataSource)
    }
    
    public func dataSourceAtIndex(index: Int) -> DataSource {
        return collection.dataSourceAtIndex(index)
    }

    public func containsDataSource(dataSource: DataSource) -> Bool {
        return collection.containsDataSource(dataSource)
    }

    public func indexOfDataSource(dataSource: DataSource) -> Int? {
        return collection.indexOfDataSource(dataSource)
    }

    // MARK:- IndexPath and Section translations
    
    public func globalSectionForLocalSection(localSection: Int, dataSource: DataSource) -> Int {
        return collection.globalSectionForLocalSection(localSection, dataSource: dataSource)
    }
    
    public func localSectionForGlobalSection(section: Int, dataSource: DataSource) -> Int {
        return collection.localSectionForGlobalSection(section, dataSource: dataSource)
    }

    public func globalIndexPathForLocalIndexPath(indexPath: NSIndexPath, dataSource: DataSource) -> NSIndexPath {
        return collection.globalIndexPathForLocalIndexPath(indexPath, dataSource: dataSource)
    }
    
    public func localIndexPathForGlobalIndexPath(indexPath: NSIndexPath, dataSource: DataSource) -> NSIndexPath {
        return collection.localIndexPathForGlobalIndexPath(indexPath, dataSource: dataSource)
    }

    // MARK:- Data Source
    
    public override func ds_shouldConsumeItemSizeDelegateCalls() -> Bool {
        if dataSources.isEmpty {
            return false
        }
        // if all data sources should consume item size delegates
        return dataSources.filter { $0.ds_shouldConsumeItemSizeDelegateCalls() }.count == dataSources.count
    }

    // MARK: Cell
    
    public override func ds_numberOfSections() -> Int {
        return collection.numberOfSections()
    }

    public override func ds_numberOfItems(inSection section: Int) -> Int {
        return collection.numberOfItems(inSection: section)
    }

    public override func ds_collectionView(collectionView: GeneralCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, cellForItemAtIndexPath: mapping.localIndexPath)
    }

    // MARK: Size
    
    public override func ds_collectionView(collectionView: GeneralCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, sizeForItemAtIndexPath: mapping.localIndexPath)
    }
    
    // MARK: Selection
    
    public override func ds_collectionView(collectionView: GeneralCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, shouldHighlightItemAtIndexPath: mapping.localIndexPath)
    }

    public override func ds_collectionView(collectionView: GeneralCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, didHighlightItemAtIndexPath: mapping.localIndexPath)
    }

    public override func ds_collectionView(collectionView: GeneralCollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(collectionView, didUnhighlightItemAtIndexPath: mapping.localIndexPath)
    }
    
    public override func ds_collectionView(collectionView: GeneralCollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(collectionView, shouldSelectItemAtIndexPath: mapping.localIndexPath)
    }

    public override func ds_collectionView(collectionView: GeneralCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, didSelectItemAtIndexPath: mapping.localIndexPath)
    }
    
    public override func ds_collectionView(collectionView: GeneralCollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(collectionView, shouldDeselectItemAtIndexPath: mapping.localIndexPath)
    }

    public override func ds_collectionView(collectionView: GeneralCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let mapping = collection.collectionViewWrapperFromIndexPath(indexPath, collectionView: collectionView)
        return mapping.dataSource.ds_collectionView(mapping.wrapperView, didDeselectItemAtIndexPath: mapping.localIndexPath)
    }
}
