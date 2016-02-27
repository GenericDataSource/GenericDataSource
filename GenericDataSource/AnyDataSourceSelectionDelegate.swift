//
//  AnyDataSourceSelectionDelegate.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/14/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

/**
 *  Type-erasure for `DataSourceSelectionDelegate`.
 */
public struct AnyDataSourceSelectionDelegate<ItemType, CellType: ReusableCell> : DataSourceSelectionDelegate {

    private let shouldHighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Bool
    private let didHighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    private let didUnhighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    
    private let willSelect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> NSIndexPath?
    private let didSelect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    
    private let willDeselect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> NSIndexPath?
    private let didDeselect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void

    init<C: DataSourceSelectionDelegate where C.ItemType == ItemType, C.CellType == CellType>(_ selectionDelegate: C) {
        shouldHighlight = selectionDelegate.dataSource:collectionView:shouldHighlightItemAtIndexPath:
        didHighlight = selectionDelegate.dataSource:collectionView:didHighlightItemAtIndexPath:
        didUnhighlight = selectionDelegate.dataSource:collectionView:didUnhighlightItemAtIndexPath:
        
        willSelect = selectionDelegate.dataSource:collectionView:willSelectItemAtIndexPath:
        didSelect = selectionDelegate.dataSource:collectionView:didSelectItemAtIndexPath:
        
        willDeselect = selectionDelegate.dataSource:collectionView:willDeselectItemAtIndexPath:
        didDeselect = selectionDelegate.dataSource:collectionView:didDeselectItemAtIndexPath:
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
        willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return willSelect(dataSource, collectionView, indexPath)
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
        willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return willDeselect(dataSource, collectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            return didDeselect(dataSource, collectionView, indexPath)
    }
}


extension DataSourceSelectionDelegate {
    
    func anyDataSourceSelectionDelegate() -> AnyDataSourceSelectionDelegate<ItemType, CellType> {
        return AnyDataSourceSelectionDelegate(self)
    }
}