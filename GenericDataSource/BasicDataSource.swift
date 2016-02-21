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

    public let reuseIdentifier: String
    
    public init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }

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

    public override func ds_numberOfSections() -> Int {
        return 1
    }

    public override func ds_numberOfItems(inSection section: Int) -> Int {
        return items.count
    }

    public override func ds_collectionView(collectionView: CollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

        let cell = ds_collectionView(collectionView, nonConfiguredCellForItemAtIndexPath: indexPath)
        let item: ItemType = itemAtIndexPath(indexPath)
        configure(collectionView: collectionView, cell: cell, item: item, indexPath: indexPath)
        return cell
    }

    public func ds_collectionView(collectionView: CollectionView, nonConfiguredCellForItemAtIndexPath indexPath: NSIndexPath) -> CellType {

        let cell = collectionView.dequeueReusableCellViewWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        guard let castedCell = cell as? CellType else {
            fatalError("cell: \(cell) with reuse identifier '\(reuseIdentifier)' expected to be of type \(CellType.self).")
        }
        return castedCell
    }

    public func configure(collectionView collectionView: CollectionView, cell: CellType, item: ItemType, indexPath: NSIndexPath) {
        // does nothing
        // should be overriden by subclasses
    }

    // MARK: Size

    public override func ds_canHandleCellSize() -> Bool {
        return itemSize != nil
    }

    public override func ds_collectionView(collectionView: CollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let itemSize = itemSize else {
            fatalError("sizeForItemAtIndexPath requested with nil itemSize.")
        }
        return itemSize
    }

    // MARK: Selection
    public override func ds_collectionView(collectionView: CollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return selectionController?.dataSource(self, collectionView: collectionView, shouldHighlightItemAtIndexPath: indexPath) ??
            super.ds_collectionView(collectionView, shouldHighlightItemAtIndexPath: indexPath)
    }
    
    public override func ds_collectionView(collectionView: CollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, collectionView: collectionView, didHighlightItemAtIndexPath: indexPath)
    }
    
    public override func ds_collectionView(collectionView: CollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, collectionView: collectionView, didUnhighlightItemAtIndexPath: indexPath)
    }

    public override func ds_collectionView(collectionView: CollectionView, willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return selectionController?.dataSource(self, collectionView: collectionView, willSelectItemAtIndexPath: indexPath) ??
            super.ds_collectionView(collectionView, willSelectItemAtIndexPath: indexPath)
    }
    
    public override func ds_collectionView(collectionView: CollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, collectionView: collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    public override func ds_collectionView(collectionView: CollectionView, willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return selectionController?.dataSource(self, collectionView: collectionView, willDeselectItemAtIndexPath: indexPath) ??
            super.ds_collectionView(collectionView, willDeselectItemAtIndexPath: indexPath)
    }

    public override func ds_collectionView(collectionView: CollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        selectionController?.dataSource(self, collectionView: collectionView, didDeselectItemAtIndexPath: indexPath)
    }
}

public class BasicBlockDataSource<ItemType, CellType: ReusableCell> : BasicDataSource <ItemType, CellType> {

    public typealias ConfigureBlock = (item: ItemType, cell: CellType, indexPath: NSIndexPath) -> Void
    let configureBlock: ConfigureBlock

    public init(reuseIdentifier: String, configureBlock: ConfigureBlock) {
        self.configureBlock = configureBlock
        super.init(reuseIdentifier: reuseIdentifier)
    }

    public override func configure(collectionView collectionView: CollectionView, cell: CellType, item: ItemType, indexPath: NSIndexPath) {
        self.configureBlock(item: item, cell: cell, indexPath: indexPath)
    }

}