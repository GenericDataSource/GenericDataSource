//
//  ColorsDataSource.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class ColorsDataSource<CellType: ReusableCell where CellType: UIView>: BasicDataSource<Color, CellType> {

    // This is needed as of swift 2.2, because if you subclassed a generic class, initializers are not inherited.
    override init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    override func ds_collectionView(collectionView collectionView: GeneralCollectionView, configureCell cell: CellType, withItem item: Color, atIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = item.color
    }
}