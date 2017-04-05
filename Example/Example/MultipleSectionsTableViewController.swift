//
//  MultipleSectionsTableViewController.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class MultipleSectionsTableViewController: UICollectionViewController {

    let dataSource = CompositeDataSource(sectionType: .multi)
    let colorsDataSource = ColorsDataSource<ColorCollectionViewCell>()
    let contactsDataSource = ContactsDataSource<ContactCollectionViewCell>()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.ds_register(cellClass: ColorCollectionViewCell.self)
        collectionView?.ds_register(cellNib: ContactCollectionViewCell.self)
        collectionView?.ds_useDataSource(dataSource)

        colorsDataSource.itemSize = CGSize(width: 70, height: 70)
        contactsDataSource.itemSize = CGSize(width: 150, height: 50)

        dataSource.add(contactsDataSource)
        dataSource.add(colorsDataSource)

        colorsDataSource.items = Service.getFewColors()
        contactsDataSource.items = Service.getContacts()

        colorsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "color"))
        contactsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "contact"))
    }

    @IBAction func exchangeButtonTapped(_ sender: AnyObject) {
        // update the data source
        let firstDataSource = dataSource.dataSource(at: 0)
        dataSource.remove(firstDataSource)
        dataSource.add(firstDataSource)

        // update the table view
        dataSource.ds_reusableViewDelegate?.ds_performBatchUpdates({ [weak self] in
            self?.dataSource.ds_reusableViewDelegate?.ds_moveSection(0, toSection: 1)
            }, completion: nil)
    }

}
