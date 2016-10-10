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
        _ dataSource: BasicDataSource<ItemType, CellType>,
        collectionView: GeneralCollectionView,
        didSelectItemAt indexPath: IndexPath) {
        UIAlertView(title: "", message: dataSource.item(at: indexPath).name + " " + typeName + " tapped!", delegate: nil, cancelButtonTitle: "Ok").show()
    }
}
