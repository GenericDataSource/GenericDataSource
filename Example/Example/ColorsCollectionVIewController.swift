//
//  ColorsCollectionVIewController.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class ColorsCollectionVIewController: UICollectionViewController {

    private let dataSource = ColorsDataSource<UICollectionViewCell>(reuseIdentifier: "cell")

    override func viewDidLoad() {

        dataSource.items = Service.getColors()
        collectionView?.ds_useDataSource(dataSource)
    }
}
