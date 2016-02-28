//
//  BasicBlockDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/27/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

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