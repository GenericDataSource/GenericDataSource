//
//  MockCollectionView.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit
import XCTest
@testable import GenericDataSource

protocol MockReusableView: GeneralCollectionView {

    func ueryDataSource()
}

class MockTableView: UITableView {

    var reusableCells: [String: (type: UITableViewCell.Type, cells: [Int: UITableViewCell])] = [:]

    var numberOfReuseCells: Int = 10

    var sectionsCount: Int = 0
    var itemsCountPerSection: [Int] = []
    var cells: [[UITableViewCell]] = []
    var reusableHeaders: [String: UITableViewHeaderFooterView.Type] = [:]

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        guard reusableCells[identifier] == nil else {
            assertionFailure("A cell with the same identifier '\(identifier)' already registered before.")
            return
        }
        guard let theCellClass = cellClass as? UITableViewCell.Type else {
            assertionFailure("'\(cellClass)' should be of type UITableViewCell")
            return
        }

        reusableCells[identifier] = (theCellClass, [:])
    }

    override func register(_ aClass: AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String) {
        reusableHeaders[identifier] = aClass as? UITableViewHeaderFooterView.Type
    }

    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = reusableCells[identifier] else {
            assertionFailure("No cell registered with identifier '\(identifier)'.")
            return UITableViewCell()
        }

        let index = indexPath.item % numberOfReuseCells

        if let cell = cellData.cells[index] {
            return cell
        } else {
            let cell = cellData.type.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            var mutableCellData = cellData
            mutableCellData.cells[index] = cell
            reusableCells[identifier] = mutableCellData
            return cell
        }
    }

    override func dequeueReusableHeaderFooterView(withIdentifier identifier: String) -> UITableViewHeaderFooterView? {
        let viewClass = reusableHeaders[identifier]
        return viewClass?.init()
    }

    func queryDataSource() {

        // clear the created cell
        for (_, var cellData) in reusableCells {
            cellData.cells.removeAll()
        }

        sectionsCount = 0
        itemsCountPerSection.removeAll()
        cells.removeAll()

        guard let dataSource = dataSource else {
            return
        }

        // sections
        sectionsCount = dataSource.numberOfSections?(in: self) ?? 1

        // items
        for section in 0..<sectionsCount {
            itemsCountPerSection.append(dataSource.tableView(self, numberOfRowsInSection: section))
        }

        // cells
        for (section, itemsCount) in itemsCountPerSection.enumerated() {
            var sectionCells: [UITableViewCell] = []
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let cell = dataSource.tableView(self, cellForRowAt: indexPath)
                sectionCells.append(cell)
            }
            cells.append(sectionCells)
        }
    }
}

class MockCollectionView: UICollectionView {

    var reusableCells: [String: (type: UICollectionViewCell.Type, cells: [Int: UICollectionViewCell])] = [:]

    var numberOfReuseCells: Int = 10

    var sectionsCount: Int = 0
    var itemsCountPerSection: [Int] = []
    var cells: [[UICollectionViewCell]] = []
    var reusableHeaders: [String: (kind: String, view: UICollectionReusableView.Type)] = [:]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    convenience init() {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        guard reusableCells[identifier] == nil else {
            assertionFailure("A cell with the same identifier '\(identifier)' already registered before.")
            return
        }
        guard let theCellClass = cellClass as? UICollectionViewCell.Type else {
            assertionFailure("'\(cellClass)' should be of type UITableViewCell")
            return
        }

        reusableCells[identifier] = (theCellClass, [:])
    }

    override func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) {
        reusableHeaders[identifier] = (elementKind, viewClass as! UICollectionReusableView.Type)
    }

    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellData = reusableCells[identifier] else {
            assertionFailure("No cell registered with identifier '\(identifier)'.")
            return UICollectionViewCell()
        }

        let index = indexPath.item % numberOfReuseCells

        if let cell = cellData.cells[index] {
            return cell
        } else {
            let cell = cellData.type.init()
            var mutableCellData = cellData
            mutableCellData.cells[index] = cell
            reusableCells[identifier] = mutableCellData
            return cell
        }
    }

    override func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = reusableHeaders[identifier]
        XCTAssertNotNil(reusableView)
        XCTAssertEqual(elementKind, reusableView?.kind)
        return reusableView!.view.init()
    }

    func queryDataSource() {

        // clear the created cell
        for (_, var cellData) in reusableCells {
            cellData.cells.removeAll()
        }

        sectionsCount = 0
        itemsCountPerSection.removeAll()
        cells.removeAll()

        guard let dataSource = dataSource else {
            return
        }

        // sections
        sectionsCount = dataSource.numberOfSections?(in: self) ?? 1

        // items
        for section in 0..<sectionsCount {
            itemsCountPerSection.append(dataSource.collectionView(self, numberOfItemsInSection: section))
        }

        // cells
        for (section, itemsCount) in itemsCountPerSection.enumerated() {
            var sectionCells: [UICollectionViewCell] = []
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let cell = dataSource.collectionView(self, cellForItemAt: indexPath)
                sectionCells.append(cell)
            }
            cells.append(sectionCells)
        }
    }
}
