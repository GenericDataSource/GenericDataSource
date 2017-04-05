//
//  MultipleAndSingleSectionsCollectionViewController.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class MultipleAndSingleSectionsCollectionViewController: UICollectionViewController {

    let dataSource = CompositeDataSource(sectionType: .multi)

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstSection = createFirstSection()
        let colorsDataSource = ColorsDataSource<ColorCollectionViewCell>()

        dataSource.add(firstSection)
        dataSource.add(colorsDataSource)

        colorsDataSource.items = Service.getFewColors()
        colorsDataSource.itemSize = CGSize(width: 70, height: 70)
        colorsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "color"))

        collectionView?.ds_register(cellNib: TitleCollectionViewCell.self)
        collectionView?.ds_register(cellNib: ContactCollectionViewCell.self)
        collectionView?.ds_register(cellClass: ColorCollectionViewCell.self)
        collectionView?.ds_useDataSource(dataSource)
    }

    fileprivate func createFirstSection() -> DataSource {
        let titleDataSource = TitleDataSource()
        titleDataSource.items = ["Mix of Multiple and Single Sectioned DataSources"]

        let contactsDataSource = ContactsDataSource<ContactCollectionViewCell>()

        let firstSection = CompositeDataSource(sectionType: .single)
        firstSection.add(titleDataSource)
        firstSection.add(contactsDataSource)

        contactsDataSource.itemSize = CGSize(width: 150, height: 50)
        contactsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "contact"))
        contactsDataSource.items = Service.getContacts()

        return firstSection
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
