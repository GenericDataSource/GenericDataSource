//
//  ContactTableViewCell.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell, ContactCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

