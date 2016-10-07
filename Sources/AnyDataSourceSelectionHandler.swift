//
//  AnyDataSourceSelectionHandler.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/14/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

/**
 *  Type-erasure for `DataSourceSelectionHandler`.
 */
public struct AnyDataSourceSelectionHandler<ItemType, CellType: ReusableCell> : DataSourceSelectionHandler {

    fileprivate let itemsChanged: (BasicDataSource<ItemType, CellType>) -> Void
    fileprivate let configureCell: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, CellType, ItemType, IndexPath) -> Void

    fileprivate let shouldHighlight: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Bool
    fileprivate let didHighlight: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Void
    fileprivate let didUnhighlight: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Void

    fileprivate let shouldSelect: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Bool
    fileprivate let didSelect: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Void

    fileprivate let shouldDeselect: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Bool
    fileprivate let didDeselect: (BasicDataSource<ItemType, CellType>, GeneralCollectionView, IndexPath) -> Void

    /**
     Create new type-erasure that wraps the passed handler.

     - parameter selectionHandler: The handler to pass to the type erasure.

     */
    public init<C: DataSourceSelectionHandler>(_ selectionHandler: C) where C.ItemType == ItemType, C.CellType == CellType {
        
        itemsChanged = selectionHandler.dataSourceItemsModified
        configureCell = selectionHandler.dataSource(_:collectionView:configureCell:withItem:atIndexPath:)

        shouldHighlight = selectionHandler.dataSource(_:collectionView:shouldHighlightItemAtIndexPath:)
        didHighlight = selectionHandler.dataSource(_:collectionView:didHighlightItemAtIndexPath:)
        didUnhighlight = selectionHandler.dataSource(_:collectionView:didUnhighlightItemAtIndexPath:)
        
        shouldSelect = selectionHandler.dataSource(_:collectionView:shouldSelectItemAtIndexPath:)
        didSelect = selectionHandler.dataSource(_:collectionView:didSelectItemAtIndexPath:)

        shouldDeselect = selectionHandler.dataSource(_:collectionView:shouldDeselectItemAtIndexPath:)
        didDeselect = selectionHandler.dataSource(_:collectionView:didDeselectItemAtIndexPath:)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSourceItemsModified(_ dataSource: BasicDataSource<ItemType, CellType>) {
        return itemsChanged(dataSource)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        configureCell cell: CellType,
        withItem item: ItemType,
        atIndexPath indexPath: IndexPath) {
            return configureCell(dataSource, collectionView, cell, item, indexPath)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldHighlightItemAtIndexPath indexPath: IndexPath) -> Bool {
            return shouldHighlight(dataSource, collectionView, indexPath)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didHighlightItemAtIndexPath indexPath: IndexPath) {
            return didHighlight(dataSource, collectionView, indexPath)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didUnhighlightItemAtIndexPath indexPath: IndexPath) {
            return didUnhighlight(dataSource, collectionView, indexPath)
    }
    
    // MARK:- Selecting

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldSelectItemAtIndexPath indexPath: IndexPath) -> Bool {
            return shouldSelect(dataSource, collectionView, indexPath)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didSelectItemAtIndexPath indexPath: IndexPath) {
            return didSelect(dataSource, collectionView, indexPath)
    }
    
    // MARK:- Deselecting

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldDeselectItemAtIndexPath indexPath: IndexPath) -> Bool {
            return shouldDeselect(dataSource, collectionView, indexPath)
    }

    /**
     Delegating to the unerlying selection handler.
     */
    public func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didDeselectItemAtIndexPath indexPath: IndexPath) {
            return didDeselect(dataSource, collectionView, indexPath)
    }
}


extension DataSourceSelectionHandler {

    public func anyDataSourceSelectionHandler() -> AnyDataSourceSelectionHandler<ItemType, CellType> {
        return AnyDataSourceSelectionHandler(self)
    }
}
