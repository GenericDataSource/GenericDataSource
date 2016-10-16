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

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CellType, with item: Color, at indexPath: IndexPath) {
        cell.backgroundColor = item.color
    }
}
