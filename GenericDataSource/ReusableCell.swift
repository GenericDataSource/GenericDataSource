//
//  ReusableCell.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 4/11/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

public protocol ReusableCell {
}

extension UITableViewCell : ReusableCell {
}

extension UICollectionViewCell : ReusableCell {
}
