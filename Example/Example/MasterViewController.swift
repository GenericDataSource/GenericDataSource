//
//  MasterViewController.swift
//  Example
//
//  Created by Mohamed Afifi on 3/28/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

private struct Model : Equatable {
    let segue: String
    let title: String
}

private func ==(lhs: Model, rhs: Model) -> Bool {
    return lhs.segue == rhs.segue && lhs.title == lhs.title
}

class MasterViewController: UITableViewController {

    private var dataSource: BasicBlockDataSource<Model, UITableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = BasicBlockDataSource<Model, UITableViewCell>(reuseIdentifier: "cell") { (item: Model, cell: UITableViewCell, _) -> Void in
            cell.textLabel?.text = item.title
            cell.contentView.backgroundColor = nil
        }

        let selectionHandler = SingleSelectionHandler<Model, UITableViewCell> { (_, _, cell, _, index, selected) in
            print(index.item, selected)
            if selected {
                cell.backgroundColor = UIColor.lightGrayColor()
                cell.textLabel?.textColor = UIColor.whiteColor()
            } else {
                cell.backgroundColor = UIColor.whiteColor()
                cell.textLabel?.textColor = UIColor.blackColor()
            }
        }
        selectionHandler.allowsDeselection = false

        dataSource.setSelectionHandler(selectionHandler)

        let models = [Model(segue: "basic", title: "BasicDataSource"),
                      Model(segue: "single", title: "CompositeDataSource (SingleSection)"),
                      Model(segue: "multiple", title: "CompositeDataSource (MultipleSection)")]
        
        tableView.ds_useDataSource(dataSource)
        dataSource.items = models

        self.dataSource = dataSource
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
}

