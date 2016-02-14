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

    private let shouldHighlight: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> Bool
    private let didHighlight: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> Void
    private let didUnhighlight: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> Void
    
    private let willSelect: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> NSIndexPath?
    private let didSelect: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> Void
    
    private let willDeselect: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> NSIndexPath?
    private let didDeselect: (BasicDataSource<ItemType, CellType>, TableCollectionView, NSIndexPath) -> Void

    init<C: SelectionController where C.ItemType == ItemType, C.CellType == CellType>(_ selectionController: C) {
        shouldHighlight = selectionController.dataSource:tableCollectionView:shouldHighlightItemAtIndexPath:
        didHighlight = selectionController.dataSource:tableCollectionView:didHighlightItemAtIndexPath:
        didUnhighlight = selectionController.dataSource:tableCollectionView:didUnhighlightItemAtIndexPath:
        
        willSelect = selectionController.dataSource:tableCollectionView:willSelectItemAtIndexPath:
        didSelect = selectionController.dataSource:tableCollectionView:didSelectItemAtIndexPath:
        
        willDeselect = selectionController.dataSource:tableCollectionView:willDeselectItemAtIndexPath:
        didDeselect = selectionController.dataSource:tableCollectionView:didDeselectItemAtIndexPath:
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return shouldHighlight(dataSource, tableCollectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didHighlightItemAtIndexPath indexPath: NSIndexPath) {
            return didHighlight(dataSource, tableCollectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
            return didUnhighlight(dataSource, tableCollectionView, indexPath)
    }
    
    // MARK:- Selecting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return willSelect(dataSource, tableCollectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            return didSelect(dataSource, tableCollectionView, indexPath)
    }
    
    // MARK:- Deselecting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return willDeselect(dataSource, tableCollectionView, indexPath)
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            return didDeselect(dataSource, tableCollectionView, indexPath)
    }
}


extension SelectionController {
    
    func anySelectionController() -> AnySelectionController<ItemType, CellType> {
        return AnySelectionController(self)
    }
}