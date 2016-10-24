//
//  BasicBlockSupplementaryViewCreator.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

open class BasicBlockSupplementaryViewCreator<ItemType, SupplementaryView: ReusableSupplementaryView>: BasicSupplementaryViewCreator<ItemType, SupplementaryView> {

    /// The configure closure type.
    public typealias ConfigureBlock = (ItemType, SupplementaryView, IndexPath) -> Void

    /// The configure block instance.
    private let configureBlock: ConfigureBlock

    public init(identifier: String, size: CGSize, configureBlock: @escaping ConfigureBlock) {
        self.configureBlock = configureBlock
        super.init(identifier: identifier, size: size)
    }

    public init(identifier: String, configureBlock: @escaping ConfigureBlock) {
        self.configureBlock = configureBlock
        super.init(identifier: identifier)
    }

    override func collectionView(_ collectionView: GeneralCollectionView, configure view: SupplementaryView, with item: ItemType, at indexPath: IndexPath) {
        self.configureBlock(item, view, indexPath)
    }
}
