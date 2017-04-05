//
//  AppStoreFeaturedAppCollectionViewCell.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import UIKit

class AppStoreFeaturedAppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
    }
}
