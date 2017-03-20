//
//  TitleForDeleteConfirmationButtonTester.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/14/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

private class _ReportBasicDataSource<CellType>: ReportBasicDataSource<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    var result: String = ""
    var indexPath: IndexPath?

    override func ds_collectionView(_ collectionView: GeneralCollectionView, titleForDeleteConfirmationButtonForItemAt indexPath: IndexPath) -> String? {
        self.indexPath =  indexPath
        return result
    }
}

class TitleForDeleteConfirmationButtonTester<CellType>: DataSourceTester where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    let dataSource: ReportBasicDataSource<CellType> = _ReportBasicDataSource<CellType>()

    var result: String {
        return "delete"
    }

    required init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView) {
        dataSource.items = Report.generate(numberOfReports: numberOfReports)
        dataSource.registerReusableViewsInCollectionView(collectionView)
        (dataSource as! _ReportBasicDataSource<CellType>).result = result
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> String? {
        return dataSource.tableView(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> String? {
        return result
    }

    func assert(result: String?, indexPath: IndexPath, collectionView: GeneralCollectionView) {
        if collectionView is UITableView {
            XCTAssertEqual(result, self.result)
            XCTAssertEqual((dataSource as! _ReportBasicDataSource<CellType>).indexPath, indexPath)
        }
    }
}

class TitleForDeleteConfirmationButtonTester2<CellType>: TitleForDeleteConfirmationButtonTester<CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {
    override var result: String {
        return "DeleteDelete"
    }
}
