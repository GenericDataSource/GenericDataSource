//
//  SingleSectionTableViewController.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class SingleSectionTableViewController: UITableViewController {

    private let dataSource = CompositeDataSource(sectionType: .single)
    private let colorsDataSource = ColorsDataSource<ColorTableViewCell>()
    private let contactsDataSource = ContactsDataSource<ContactTableViewCell>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.ds_register(cellClass: ColorTableViewCell.self)
        tableView.ds_register(cellClass: ContactTableViewCell.self)
        tableView.ds_useDataSource(dataSource)

        colorsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "color"))
        contactsDataSource.setSelectionHandler(AlertNameSelectionHandler(typeName: "contact"))

        colorsDataSource.itemHeight = 30
        contactsDataSource.itemHeight = 50

        dataSource.add(contactsDataSource)
        dataSource.add(colorsDataSource)

        colorsDataSource.items = Service.getFewColors()
        contactsDataSource.items = Service.getContacts()
    }

    @IBAction func exchangeButtonTapped(_ sender: AnyObject) {
        // update the data source
        let firstDataSource = dataSource.dataSource(at: 0)
        dataSource.remove(firstDataSource)
        dataSource.add(firstDataSource)

        // the indexes
        let numberOfItems = firstDataSource.ds_numberOfItems(inSection: 0)
        let initialIndexPaths = (0..<numberOfItems).map { IndexPath(item: $0, section: 0) }
        let firstIndex = dataSource.ds_numberOfItems(inSection: 0) - numberOfItems

        // update the table view
        dataSource.ds_reusableViewDelegate?.ds_performBatchUpdates({ [weak self] in
            for index in initialIndexPaths {
                self?.dataSource.ds_reusableViewDelegate?.ds_moveItem(at: index, to: IndexPath(item: firstIndex + index.item, section: 0))
            }
            }, completion: nil)
    }
}
