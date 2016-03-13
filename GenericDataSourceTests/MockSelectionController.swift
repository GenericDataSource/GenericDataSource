//
//  MockSelectionController.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/28/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
@testable import GenericDataSource

class MockSelectionController<ItemType, CellType: ReusableCell> : DataSourceSelectionHandler {
    
    var shouldHighlightCalled = false
    var didHighlightCalled = false
    var didUnhighlightCalled = false
    var shouldSelectCalled = false
    var didSelectCalled = false
    var shouldDeselectCalled = false
    var didDeselectCalled = false
    var itemsModifiedCalled = false
    var configureCellCalled = false
    
    var cell: CellType?
    var item: ItemType?
    var indexPath: NSIndexPath?

    func dataSourceItemsModified(dataSource: BasicDataSource<ItemType, CellType>) {
        itemsModifiedCalled = true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        configureCell cell: CellType,
        withItem item: ItemType,
        atIndexPath indexPath: NSIndexPath) {
            configureCellCalled = true
            self.cell = cell
            self.item = item
            self.indexPath = indexPath
    }
    
    // MARK:- Highlighting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            shouldHighlightCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didHighlightItemAtIndexPath indexPath: NSIndexPath) {
            didHighlightCalled = true
            self.indexPath = indexPath
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
            didUnhighlightCalled = true
            self.indexPath = indexPath
    }
    
    // MARK:- Selecting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            shouldSelectCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            didSelectCalled = true
            self.indexPath = indexPath
    }
    
    // MARK:- Deselecting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            shouldDeselectCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: CollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            didDeselectCalled = true
            self.indexPath = indexPath
    }
}