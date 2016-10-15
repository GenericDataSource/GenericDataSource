//
//  ReusableSupplementaryView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/15/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

@objc public protocol ReusableSupplementaryView {
}

extension UITableViewHeaderFooterView : ReusableSupplementaryView {
}

extension UICollectionReusableView : ReusableSupplementaryView {
}
