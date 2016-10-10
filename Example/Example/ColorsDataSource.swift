//
//  ColorsDataSource.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class ColorsDataSource<CellType: ReusableCell>: BasicDataSource<Color, CellType> where CellType: UIView {

    // This is needed as of swift 2.2, because if you subclassed a generic class, initializers are not inherited.
    override init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CellType, with item: Color, at indexPath: IndexPath) {
        cell.backgroundColor = item.color
    }
}
