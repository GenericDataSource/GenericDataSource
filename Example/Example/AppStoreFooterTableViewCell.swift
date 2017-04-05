//
//  AppStoreFooterTableViewCell.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import UIKit

class AppStoreActionRoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.4039215686, green: 0.4039215686, blue: 0.4039215686, alpha: 1).cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 6
    }
}

class AppStoreFooterTableViewCell: UITableViewCell {
}
