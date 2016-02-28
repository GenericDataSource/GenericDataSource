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

    private let shouldHighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Bool
    private let didHighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    private let didUnhighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void

    private let shouldSelect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Bool
    private let didSelect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void

    private let shouldDeselect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Bool
    private let didDeselect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void

    init<C: DataSourceSelectionHandler where C.ItemType == ItemType, C.CellType == CellType>(_ selectionHandler: C) {
        shouldHighlight = selectionHandler.dataSource:collectionView:shouldHighlightItemAtIndexPath:
        didHighlight = selectionHandler.dataSource:collectionView:didHighlightItemAtIndexPath:
        didUnhighlight = selectionHandler.dataSource:collectionView:didUnhighlightItemAtIndexPath:
        
        shouldSelect = selectionHandler.dataSource:collectionView:shouldSelectItemAtIndexPath:
        didSelect = selectionHandler.dataSource:collectionView:didSelectItemAtIndexPath:
        
        shouldDeselect = selectionHandler.dataSource:collectionView:shouldDeselectItemAtIndexPath:
        didDeselect = selectionHandler.dataSource:collectionView:didDeselectItemAtIndexPath:
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return shouldHighlight(dataSource, collectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didHighlightItemAtIndexPath indexPath: NSIndexPath) {
            return didHighlight(dataSource, collectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
            return didUnhighlight(dataSource, collectionView, indexPath)
    }
    
    // MARK:- Selecting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return shouldSelect(dataSource, collectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            return didSelect(dataSource, collectionView, indexPath)
    }
    
    // MARK:- Deselecting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return shouldDeselect(dataSource, collectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            return didDeselect(dataSource, collectionView, indexPath)
    }
}


extension DataSourceSelectionHandler {
    
    func anyDataSourceSelectionHandler() -> AnyDataSourceSelectionHandler<ItemType, CellType> {
        return AnyDataSourceSelectionHandler(self)
    }
}