//
//  TableView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/27/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit
import GenericDataSource

class TableView: UITableView {

    func reset() {
        indexPath = nil
        identifier = nil
        section = nil
        cellClass = nil
        nib = nil
        called = false
        sectionsSet = nil
        animation = nil
        toSection = nil
        indexPaths = nil
        toIndexPath = nil
        scrollPosition = nil
        animated = nil
        cell = nil
        dequeCell = UITableViewCell()
        point = nil
        cells = []
    }

    var indexPath: IndexPath?
    var identifier: String?
    var section: Int?
    var called = false
    var sectionsSet: IndexSet?
    var animation: UITableViewRowAnimation?
    var indexPaths: [IndexPath]?
    var scrollPosition: UITableViewScrollPosition?
    var animated: Bool?
    var cell: UITableViewCell?

    var cellClass: AnyClass?
    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        self.cellClass = cellClass
        self.identifier = identifier
    }

    var nib: UINib?
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        self.nib = nib
        self.identifier = identifier
    }

    var dequeCell = UITableViewCell()
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        self.identifier = identifier
        self.indexPath = indexPath

        return dequeCell
    }

    var sections: Int = 0
    override var numberOfSections: Int {
        return sections
    }

    var items: Int = 0
    override func numberOfRows(inSection section: Int) -> Int {
        self.section = section
        return items
    }


    override func reloadData() {
        called = true
    }

    override func ds_performBatchUpdates(_ updates: (() -> Void)?, completion: ((Bool) -> Void)?) {
        called = true
    }

    override func insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        sectionsSet = sections
        self.animation = animation
    }

    override func deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        sectionsSet = sections
        self.animation = animation
    }

    override func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        sectionsSet = sections
        self.animation = animation
    }

    var toSection: Int?
    override func moveSection(_ section: Int, toSection newSection: Int) {
        self.section = section
        toSection = newSection
    }

    override func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        self.indexPaths = indexPaths
        self.animation = animation
    }

    override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        self.indexPaths = indexPaths
        self.animation = animation
    }

    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
        self.indexPaths = indexPaths
        self.animation = animation
    }

    var toIndexPath: IndexPath?
    override func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        self.indexPath = indexPath
        self.toIndexPath = newIndexPath
    }

    override func scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableViewScrollPosition, animated: Bool) {
        self.indexPath = indexPath
        self.scrollPosition = scrollPosition
        self.animated = animated
    }

    override func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        self.indexPath = indexPath
        self.animated = animated
        self.scrollPosition = scrollPosition
    }

    override func deselectRow(at indexPath: IndexPath, animated: Bool) {
        self.indexPath = indexPath
        self.animated = animated
    }

    override func indexPath(for cell: UITableViewCell) -> IndexPath? {
        self.cell = cell
        return indexPath
    }

    var point: CGPoint?
    override func indexPathForRow(at point: CGPoint) -> IndexPath? {
        self.point = point
        return indexPath
    }

    override var indexPathsForVisibleRows: [IndexPath]? {
        return indexPaths ?? []
    }

    override var indexPathsForSelectedRows: [IndexPath]? {
        return indexPaths ?? []
    }

    var cells: [UITableViewCell] = []
    override var visibleCells: [UITableViewCell] {
        return cells
    }

    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        self.indexPath = indexPath
        return cell
    }
}
