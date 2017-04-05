//
//  RootViewController.swift
//  Example
//
//  Created by Mohamed Afifi on 3/28/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class RootViewController: UITableViewController {

    private var dataSource: BasicBlockDataSource<Example, BasicTableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = BasicBlockDataSource<Example, BasicTableViewCell>() { (item: Example, cell: BasicTableViewCell, indexPath) -> Void in
            cell.textLabel?.text = item.title
            cell.contentView.backgroundColor = nil
            cell.accessoryType = .disclosureIndicator
        }

        // Need to keep a strong reference to our data source.
        self.dataSource = dataSource

        // register the cell
        tableView.ds_register(cellClass: BasicTableViewCell.self)
        // bind the data source to the table view
        tableView.ds_useDataSource(dataSource)

        dataSource.items = Service.getExamples()

        // optionally adding a selection handler
        let selectionHandler = BlockSelectionHandler<Example, BasicTableViewCell>()
        selectionHandler.didSelectBlock = { [weak self] dataSource, _, indexPath in
            let item = dataSource.item(at: indexPath)
            self?.performSegue(withIdentifier: item.segue, sender: self)
        }
        dataSource.setSelectionHandler(selectionHandler)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let indexPath = dataSource?.ds_reusableViewDelegate?.ds_indexPathsForSelectedItems().first {
            let item = dataSource?.item(at: indexPath)
            segue.destination.title = item?.title
        }
    }
}
