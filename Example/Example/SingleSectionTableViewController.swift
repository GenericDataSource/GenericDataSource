//
//  SingleSectionTableViewController.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

extension UITableViewCell: ContactCell { }

class SingleSectionTableViewController: UITableViewController {
    
    let dataSource = CompositeDataSource(type: .SingleSection)
    let colorsDataSource = ColorsDataSource<UITableViewCell>(reuseIdentifier: "color")
    let contactsDataSource = ContactsDataSource<UITableViewCell>(reuseIdentifier: "contact")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.ds_useDataSource(dataSource)
        
        colorsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "color"))
        contactsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "contact"))

        colorsDataSource.itemHeight = 30
        contactsDataSource.itemHeight = 50

        dataSource.addDataSource(contactsDataSource)
        dataSource.addDataSource(colorsDataSource)

        colorsDataSource.items = Service.getFewColors()
        contactsDataSource.items = Service.getContacts()
    }

    @IBAction func exchangeButtonTapped(sender: AnyObject) {
        // update the data source
        let firstDataSource = dataSource.dataSourceAtIndex(0)
        dataSource.removeDataSource(firstDataSource)
        dataSource.addDataSource(firstDataSource)

        // the indexes
        let numberOfItems = firstDataSource.ds_numberOfItems(inSection: 0)
        let initialIndexPaths = (0..<numberOfItems).map { NSIndexPath(forItem: $0, inSection: 0) }
        let firstIndex = dataSource.ds_numberOfItems(inSection: 0) - numberOfItems

        // update the table view
        dataSource.ds_reusableViewDelegate?.ds_performBatchUpdates({ [weak self] in
            for index in initialIndexPaths {
                self?.dataSource.ds_reusableViewDelegate?.ds_moveItemAtIndexPath(index, toIndexPath: NSIndexPath(forItem: firstIndex + index.item, inSection: 0))
            }
            }, completion: nil)
    }
    
}
