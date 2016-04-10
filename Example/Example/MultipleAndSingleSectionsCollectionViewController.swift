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
    
    let dataSource = CompositeDataSource(type: .MultiSection)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstSection = createFirstSection()
        let colorsDataSource = ColorsDataSource<UICollectionViewCell>(reuseIdentifier: "color")
        
        dataSource.addDataSource(firstSection)
        dataSource.addDataSource(colorsDataSource)

        colorsDataSource.items = Service.getFewColors()
        colorsDataSource.itemSize = CGSize(width: 70, height: 70)
        colorsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "color"))

        collectionView?.ds_useDataSource(dataSource)
    }

    private func createFirstSection() -> DataSource {
        let titleDataSource = TitleDataSource(reuseIdentifier: "title")
        titleDataSource.items = ["Mix of Multiple and Single Sectioned DataSources"]
        
        let contactsDataSource = ContactsDataSource<ContactCollectionViewCell>(reuseIdentifier: "contact")

        let firstSection = CompositeDataSource(type: .SingleSection)
        firstSection.addDataSource(titleDataSource)
        firstSection.addDataSource(contactsDataSource)

        contactsDataSource.itemSize = CGSize(width: 150, height: 50)
        contactsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "contact"))
        contactsDataSource.items = Service.getContacts()

        return firstSection
    }

    @IBAction func exchangeButtonTapped(sender: AnyObject) {
        // update the data source
        let firstDataSource = dataSource.dataSourceAtIndex(0)
        dataSource.removeDataSource(firstDataSource)
        dataSource.addDataSource(firstDataSource)
        
        // update the table view
        dataSource.ds_reusableViewDelegate?.ds_performBatchUpdates({ [weak self] in
            self?.dataSource.ds_reusableViewDelegate?.ds_moveSection(0, toSection: 1)
            }, completion: nil)
    }
    
}