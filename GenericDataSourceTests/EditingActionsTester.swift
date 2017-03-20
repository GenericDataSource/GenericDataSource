//
//  EditingActionsTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/14/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var result: [UITableViewRowAction]?
    var indexPath: IndexPath?

    override func ds_collectionView(_ collectionView: GeneralCollectionView, editActionsForItemAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        self.indexPath =  indexPath
        return result
    }
}

class EditingActionsTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    var result: [UITableViewRowAction]? {
        return nil
    }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        (dataSource as! _ReportBasicDataSource<CellType>).result = result
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> [UITableViewRowAction]? {
        return dataSource.tableView(tableView, editActionsForRowAt: indexPath)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> [UITableViewRowAction]? {
        return result
    }

    func assert(result: [UITableViewRowAction]?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        if collectionView is UITableView {
            XCTAssertIdentical(result, self.result)
            XCTAssertEqual((dataSource as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
        }
    }
}

let actions = [UITableViewRowAction(style: .destructive, title: "Edit", handler: { _ in })]
class EditingActionsTester2<CellType>: EditingActionsTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    override var result: [UITableViewRowAction]? {
        return actions
    }
}
