//
//  SingleSelectionHandler.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/28/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public class SingleSelectionHandler<ItemType: Equatable, CellType: ReusableCell> : DataSourceSelectionHandler {
    
    public typealias ConfigurationBlock = (BasicDataSource<ItemType, CellType>, GeneralCollectionView, CellType, ItemType, NSIndexPath, selected: Bool) -> Void

    public typealias SelectedItemChange = (oldItem: ItemType?, newItem: ItemType?) -> Void

    public var selectedItem: ItemType? {
        didSet {
            onSelectedItemChanged?(oldItem: oldValue, newItem: selectedItem)
        }
    }

    public let configureBlock: ConfigurationBlock
    public var onSelectedItemChanged: SelectedItemChange?

    public var allowsDeselection: Bool = true

    public init(configureBlock: ConfigurationBlock) {
        self.configureBlock = configureBlock
    }

    public func dataSourceItemsModified(dataSource: BasicDataSource<ItemType, CellType>) {
        if let selectedItem = selectedItem where !dataSource.items.contains(selectedItem) {
            // update the model
            self.selectedItem = nil
        }
    }

    public func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        configureCell cell: CellType,
        withItem item: ItemType,
        atIndexPath indexPath: NSIndexPath) {
        configureBlock(dataSource, collectionView, cell, item, indexPath, selected: item == selectedItem)
    }

    public func dataSource(
        theDataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {

        // deselect the item, as we keep the selection ourselves
        collectionView.ds_deselectItemAtIndexPath(indexPath, animated: false)

        // update the model
        let oldSelectedItem = selectedItem
        let newSelectedItem = theDataSource.itemAtIndexPath(indexPath)

        var reloadIndices: [NSIndexPath] = []

        if newSelectedItem != oldSelectedItem {
            selectedItem = newSelectedItem
            reloadIndices.append(indexPath)
            
            if let oldSelectedItem = oldSelectedItem,
                let oldSelectedIndexPath = theDataSource.indexPathForItem(oldSelectedItem) {
                reloadIndices.append(oldSelectedIndexPath)
            }
        } else {
            if allowsDeselection {
                // deselect
                selectedItem = nil

                reloadIndices.append(indexPath)
            }
        }

        if !reloadIndices.isEmpty {
            collectionView.ds_performBatchUpdates({ 
                collectionView.ds_reloadItemsAtIndexPaths(reloadIndices, withRowAnimation: .Automatic)
                }, completion: nil)
        }
    }

    public func dataSource(dataSource: BasicDataSource<ItemType, CellType>, collectionView: GeneralCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("test")
    }

    private func cellFromCollectionView(collectionView: GeneralCollectionView, atIndexPath indexPath: NSIndexPath) -> CellType? {
        return collectionView.ds_cellForItemAtIndexPath(indexPath).flatMap { cell in
            guard let castedCell = cell as? CellType else {
                fatalError("Couldn't cast cell: \(cell) at local index path '\(indexPath)' expected to be of type \(CellType.self).")
            }
            return castedCell
        }
    }
}