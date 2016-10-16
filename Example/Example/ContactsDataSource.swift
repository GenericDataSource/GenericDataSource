//
//  ContactsDataSource.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

protocol ContactCell: ReusableCell {
    var textLabel: UILabel? { get}
    var detailTextLabel: UILabel? { get}
}

class ContactsDataSource<CellType: ContactCell>: BasicDataSource<Contact, CellType> {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: CellType, with item: Contact, at indexPath: IndexPath) {
        cell.configureForContact(item)
    }
}

extension ContactCell {
    fileprivate func configureForContact(_ contact: Contact) {
        textLabel?.text = contact.name
        detailTextLabel?.text = contact.email
    }
}
