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

        let selectionHandler = BlockSelectionHandler<Model, UITableViewCell>()
        selectionHandler.didSelectBlock = { [weak self] dataSource, _, indexPath in
            let item = dataSource.itemAtIndexPath(indexPath)
            self?.performSegueWithIdentifier(item.segue, sender: self)
        }

        dataSource.setSelectionHandler(selectionHandler)

        let models = [Model(segue: "basic", title: "BasicDataSource"),
                      Model(segue: "basic", title: "CompositeDataSource (SingleSection)"),
                      Model(segue: "basic", title: "CompositeDataSource (MultipleSection)")]
        
        tableView.ds_useDataSource(dataSource)
        dataSource.items = models

        self.dataSource = dataSource
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
}
