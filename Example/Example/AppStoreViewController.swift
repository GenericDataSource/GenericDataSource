//
//  AppStoreViewController.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class AppStoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    let dataSource = AppStoreDataSource()

    let service = Service()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.ds_register(cellNib: AppStoreFeaturedSectionTableViewCell.self)
        tableView.ds_register(cellNib: AppStoreQuickLinkLabelTableViewCell.self)
        tableView.ds_register(cellNib: AppStoreQuickLinkTableViewCell.self)
        tableView.ds_register(cellNib: AppStoreFooterTableViewCell.self)
        tableView.ds_register(cellNib: AppStoreLoadingTableViewCell.self)
        tableView.ds_useDataSource(dataSource)

        loadData()
    }

    @IBAction func onRefreshTapped(_ sender: Any) {
        loadData()
    }

    private func loadData() {
        // update the UI
        refreshButton.isEnabled = false
        dataSource.selectedDataSourceIndex = 0

        // get the data from the service
        service.getFeaturedPage { [weak self] page in

            // update the model
            self?.dataSource.page.page = page

            // update the UI
            self?.refreshButton.isEnabled = true
            self?.dataSource.selectedDataSourceIndex = 1
        }
    }
}
