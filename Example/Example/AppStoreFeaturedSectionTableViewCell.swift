//
//  AppStoreFeaturedSectionTableViewCell.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import UIKit

class AppStoreFeaturedSectionTableViewCell: UITableViewCell {

    let dataSource = AppStoreFeaturedAppsDataSource()

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.ds_register(cellNib: AppStoreFeaturedAppCollectionViewCell.self)
        collectionView.ds_useDataSource(dataSource)
    }

    override var layoutMargins: UIEdgeInsets {
        get {
            let layoutMargins = super.layoutMargins
            return UIEdgeInsets(top: layoutMargins.top, left: 15, bottom: layoutMargins.bottom, right: layoutMargins.right)
        } set {
            super.layoutMargins = newValue
        }
    }
}
