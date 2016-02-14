//
//  SelectionController.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/14/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol SelectionController {
    
    typealias ItemType
    typealias CellType: ReusableCell
    
    // MARK:- Highlighting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didHighlightItemAtIndexPath indexPath: NSIndexPath)
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didUnhighlightItemAtIndexPath indexPath: NSIndexPath)
    
    // MARK:- Selecting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath)
    
    // MARK:- Deselecting
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
    
    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath)
}

// MARK:- Default implementation
extension SelectionController {
    
    // MARK:- Highlighting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didHighlightItemAtIndexPath indexPath: NSIndexPath) {
            // does nothing
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
            // does nothing
    }
    
    // MARK:- Selecting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return indexPath
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            // does nothing
    }
    
    // MARK:- Deselecting
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return indexPath
    }
    
    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        tableCollectionView: TableCollectionView,
        didDeselectItemAtIndexPath indexPath: NSIndexPath) {
            // does nothing
    }
}