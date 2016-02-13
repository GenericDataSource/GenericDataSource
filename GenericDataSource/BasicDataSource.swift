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

    public var itemsHighlightable: Bool = true

    public func itemAtIndexPath(indexPath: NSIndexPath) -> ItemType {
        return items[indexPath.item]
    }

    public func replaceItemAtIndexPath(indexPath: NSIndexPath, withItem item: ItemType) {
        items[indexPath.item] = item
    }

    public override func itemAtIndexPath(indexPath: NSIndexPath) -> Any {
        let item: ItemType = itemAtIndexPath(indexPath)
        return item
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

    public override func numberOfSections() -> Int {
        return 1
    }

    public override func numberOfItems(inSection section: Int) -> Int {
        return items.count
    }

    public override func tableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {

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

    public override func tableCollectionView(tableCollectionView: TableCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return itemsHighlightable
    }
    
    public override func canHandleCellSize() -> Bool {
        return itemSize != nil
    }
    
    public override func tableCollectionView(tableCollectionView: TableCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let itemSize = itemSize else {
            fatalError("sizeForItemAtIndexPath requested with nil itemSize.")
        }
        return itemSize
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