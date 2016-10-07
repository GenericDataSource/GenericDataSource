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

    // This is needed as of swift 2.2, because if you subclassed a generic class, initializers are not inherited.
    override init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configureCell cell: CellType, withItem item: Contact, atIndexPath indexPath: IndexPath) {
        cell.configureForContact(item)
    }
}

extension ContactCell {
    fileprivate func configureForContact(_ contact: Contact) {
        textLabel?.text = contact.name
        detailTextLabel?.text = contact.email
    }
}
