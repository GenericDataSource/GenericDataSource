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
        collectionView: GeneralCollectionView,
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
        collectionView: GeneralCollectionView,
        shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            shouldHighlightCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didHighlightItemAtIndexPath indexPath: NSIndexPath) {
            didHighlightCalled = true
            self.indexPath = indexPath
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
            didUnhighlightCalled = true
            self.indexPath = indexPath
    }
    
    // MARK:- Selecting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            shouldSelectCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            didSelectCalled = true
            self.indexPath = indexPath
    }
    
    // MARK:- Deselecting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            shouldDeselectCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            didDeselectCalled = true
            self.indexPath = indexPath
    }
}