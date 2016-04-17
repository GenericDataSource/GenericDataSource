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

    private var dataSource: BasicBlockDataSource<Example, UITableViewCell>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataSource = BasicBlockDataSource<Example, UITableViewCell>(reuseIdentifier: "cell") { (item: Example, cell: UITableViewCell, _) -> Void in
            cell.textLabel?.text = item.title
            cell.contentView.backgroundColor = nil
        }
        // Need to keep a strong reference to our data source.
        self.dataSource = dataSource

        tableView.ds_useDataSource(dataSource)
        dataSource.items = Service.getExamples()
        
        // optionally adding a selection handler
        let selectionHandler = BlockSelectionHandler<Example, UITableViewCell>()
        selectionHandler.didSelectBlock = { [weak self] dataSource, _, indexPath in
            let item = dataSource.itemAtIndexPath(indexPath)
            self?.performSegueWithIdentifier(item.segue, sender: self)
        }
        dataSource.setSelectionHandler(selectionHandler)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let indexPath = dataSource?.ds_reusableViewDelegate?.ds_indexPathsForSelectedItems().first {
            let item = dataSource?.itemAtIndexPath(indexPath)
            segue.destinationViewController.title = item?.title
        }
    }
}
