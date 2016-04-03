//
//  AlertNameSelectionHandler.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import Foundation
import GenericDataSource

protocol NameableEntity {
    var name: String { get }
}

class AlertNameSelectionHandler<ItemType: NameableEntity, CellType: ReusableCell>: DataSourceSelectionHandler {

    let typeName: String
    init(typeName: String) {
        self.typeName = typeName
    }

    func dataSource(
        dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
        UIAlertView(title: "", message: dataSource.itemAtIndexPath(indexPath).name + " " + typeName + " tapped!", delegate: nil, cancelButtonTitle: "Ok").show()
    }
}
