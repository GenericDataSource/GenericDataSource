//
//  AnySelectionController.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/14/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

/**
 *  Type-erasure for SelectionController.
 */
public struct AnySelectionController<ItemType, CellType: ReusableCell> : SelectionController {

    private let shouldHighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Bool
    private let didHighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    private let didUnhighlight: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    
    private let willSelect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> NSIndexPath?
    private let didSelect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void
    
    private let willDeselect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> NSIndexPath?
    private let didDeselect: (BasicDataSource<ItemType, CellType>, CollectionView, NSIndexPath) -> Void

    init<C: SelectionController where C.ItemType == ItemType, C.CellType == CellType>(_ selectionController: C) {
        shouldHighlight = selectionController.dataSource:collectionView:shouldHighlightItemAtIndexPath:
        didHighlight = selectionController.dataSource:collectionView:didHighlightItemAtIndexPath:
        didUnhighlight = selectionController.dataSource:collectionView:didUnhighlightItemAtIndexPath:
        
        willSelect = selectionController.dataSource:collectionView:willSelectItemAtIndexPath:
        didSelect = selectionController.dataSource:collectionView:didSelectItemAtIndexPath:
        
        willDeselect = selectionController.dataSource:collectionView:willDeselectItemAtIndexPath:
        didDeselect = selectionController.dataSource:collectionView:didDeselectItemAtIndexPath:
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


extension SelectionController {
    
    func anySelectionController() -> AnySelectionController<ItemType, CellType> {
        return AnySelectionController(self)
    }
}