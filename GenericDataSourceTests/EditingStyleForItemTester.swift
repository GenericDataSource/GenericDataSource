//
//  EditingStyleForItemTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/14/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var result: UITableViewCell.EditingStyle = .none
    var indexPath: IndexPath?

    override func ds_collectionView(_ collectionView: GeneralCollectionView, editingStyleForItemAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        self.indexPath =  indexPath
        return result
    }
}

class EditingStyleForItemTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    var result: UITableViewCell.EditingStyle {
        return .delete
    }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        ((dataSource as Any) as! _ReportBasicDataSource<CellType>).result = result
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> UITableViewCell.EditingStyle {
        return dataSource.tableView(tableView, editingStyleForRowAt: indexPath)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> UITableViewCell.EditingStyle {
        return result
    }

    func assert(result: UITableViewCell.EditingStyle, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        if collectionView is UITableView {
            XCTAssertEqual(result, self.result)
            XCTAssertEqual(((dataSource as Any) as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
        }
    }
}

class EditingStyleForItemTester2<CellType>: EditingStyleForItemTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    override var result: UITableViewCell.EditingStyle {
        return .insert
    }
}
