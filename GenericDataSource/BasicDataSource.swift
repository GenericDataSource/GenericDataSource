//
//  BasicDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

public class BasicDataSource<ItemType, CellType: ReusableCell> : AbstractDataSource {

    public var itemSize: CGSize? = nil

    public var items: [ItemType] = []

    public var reuseIdentifier: String? = nil

    public var selectionController: AnySelectionController<ItemType, CellType>? = nil

    public func itemAtIndexPath(indexPath: NSIndexPath) -> ItemType {
        return items[indexPath.item]
    }

    public func replaceItemAtIndexPath(indexPath: NSIndexPath, withItem item: ItemType) {
        items[indexPath.item] = item
    }

    public func indexPathForItem<T : Equatable>(item: T) -> NSIndexPath? {
        for (index, item) in items.enumerate() {
            if item is T {
                return NSIndexPath(forItem: index, inSection: 0)
            }
        }
        return nil
    }

    // MARK:- DataSource
    
    // MARK: Cell

    public func numberOfSections() -> Int {
        return 1
    }

    public func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }

    public func tableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

        let cell = cellOfTableCollectionView(tableCollectionView, cellForItemAtIndexPath: indexPath)
        let item: ItemType = itemAtIndexPath(indexPath)
        configure(tableCollectionView: tableCollectionView, cell: cell, item: item, indexPath: indexPath)
        return cell
    }

    private func cellOfTableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> CellType {
        guard let reuseIdentifier = reuseIdentifier else {
            return dequeCellFromTableCollectionView(tableCollectionView, cellForItemAtIndexPath: indexPath)
        }

        let cell = tableCollectionView.dequeueReusableCellViewWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        guard let castedCell = cell as? CellType else {
            fatalError("cell: \(cell) with reuse identifier '\(reuseIdentifier)' expected to be of type \(CellType.self).")
        }
        return castedCell
    }

    public func dequeCellFromTableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> CellType {
        fatalError("Should be implemented by subclasses or set reuseIdentifier to non-nil value.")
    }

    public func configure(tableCollectionView tableCollectionView: TableCollectionView, cell: CellType, item: ItemType, indexPath: NSIndexPath) {
        // does nothing
        // should be overriden by subclasses
    }

    // MARK: Size

    public func canHandleCellSize() -> Bool {
        return itemSize != nil
    }

    public func tableCollectionView(tableCollectionView: TableCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let itemSize = itemSize else {
            fatalError("sizeForItemAtIndexPath requested with nil itemSize.")
        }
        return itemSize
    }

    // MARK: Selection
    public func tableCollectionView(tableCollectionView: TableCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return selectionController?.dataSource(self, tableCollectionView: tableCollectionView, shouldHighlightItemAtIndexPath: indexPath) ??
            super.tableCollectionView(tableCollectionView, shouldHighlightItemAtIndexPath: indexPath)
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, tableCollectionView: tableCollectionView, didHighlightItemAtIndexPath: indexPath)
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, tableCollectionView: tableCollectionView, didUnhighlightItemAtIndexPath: indexPath)
    }

    public func tableCollectionView(tableCollectionView: TableCollectionView, willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return selectionController?.dataSource(self, tableCollectionView: tableCollectionView, willSelectItemAtIndexPath: indexPath) ??
            super.tableCollectionView(tableCollectionView, willSelectItemAtIndexPath: indexPath)
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, tableCollectionView: tableCollectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return selectionController?.dataSource(self, tableCollectionView: tableCollectionView, willDeselectItemAtIndexPath: indexPath) ??
            super.tableCollectionView(tableCollectionView, willDeselectItemAtIndexPath: indexPath)
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, tableCollectionView: tableCollectionView, didDeselectItemAtIndexPath: indexPath)
    }
}

public class BasicBlockDataSource<ItemType, CellType: ReusableCell> : BasicDataSource <ItemType, CellType> {

    public typealias ConfigureBlock = (item: ItemType, cell: CellType, indexPath: NSIndexPath) -> Void
    let configureBlock: ConfigureBlock

    public init(configureBlock: ConfigureBlock) {
        self.configureBlock = configureBlock
    }

    public override func configure(tableCollectionView tableCollectionView: TableCollectionView, cell: CellType, item: ItemType, indexPath: NSIndexPath) {
        self.configureBlock(item: item, cell: cell, indexPath: indexPath)
    }

}