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
    var indexPath: IndexPath?

    func dataSourceItemsModified(_ dataSource: BasicDataSource<ItemType, CellType>) {
        itemsModifiedCalled = true
    }
    
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        configureCell cell: CellType,
        withItem item: ItemType,
        atIndexPath indexPath: IndexPath) {
            configureCellCalled = true
            self.cell = cell
            self.item = item
            self.indexPath = indexPath
    }
    
    // MARK:- Highlighting
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldHighlightItemAtIndexPath indexPath: IndexPath) -> Bool {
            shouldHighlightCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didHighlightItemAtIndexPath indexPath: IndexPath) {
            didHighlightCalled = true
            self.indexPath = indexPath
    }
    
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didUnhighlightItemAtIndexPath indexPath: IndexPath) {
            didUnhighlightCalled = true
            self.indexPath = indexPath
    }
    
    // MARK:- Selecting
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldSelectItemAtIndexPath indexPath: IndexPath) -> Bool {
            shouldSelectCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didSelectItemAtIndexPath indexPath: IndexPath) {
            didSelectCalled = true
            self.indexPath = indexPath
    }
    
    // MARK:- Deselecting
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        shouldDeselectItemAtIndexPath indexPath: IndexPath) -> Bool {
            shouldDeselectCalled = true
            self.indexPath = indexPath
            return true
    }
    
    func dataSource(
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didDeselectItemAtIndexPath indexPath: IndexPath) {
            didDeselectCalled = true
            self.indexPath = indexPath
    }
}
