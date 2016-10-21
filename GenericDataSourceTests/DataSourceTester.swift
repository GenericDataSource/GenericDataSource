//
//  DataSourceTester.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/18/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource
import XCTest

protocol DataSourceTester {
    associatedtype DataSourceType: AbstractDataSource
    associatedtype Result
    var dataSource: DataSourceType { get }

    init(id: Int, numberOfReports: Int, collectionView: GeneralCollectionView)

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, generalCollectionView: GeneralCollectionView) -> Result
    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Result
    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Result

    func assert(result: Result, indexPath: IndexPath, collectionView: GeneralCollectionView)
    func assertNotCalled(collectionView: GeneralCollectionView)

    func cleanUp()
}

extension DataSourceTester {
    func test(indexPath: IndexPath, dataSource: AbstractDataSource, generalCollectionView: GeneralCollectionView) -> Result {
        if let tableView = generalCollectionView as? UITableView {
            return test(indexPath: indexPath, dataSource: dataSource, tableView: tableView)
        } else if let collectionView = generalCollectionView as? UICollectionView {
            return test(indexPath: indexPath, dataSource: dataSource, collectionView: collectionView)
        } else {
            fatalError("Test scenario error: collectionView: '\(generalCollectionView)' should be either UITableView or UICollectionView.")
        }
    }

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, tableView: UITableView) -> Result {
        fatalError("Should be overriden")
    }
    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: UICollectionView) -> Result {
        fatalError("Should be overriden")
    }
}

extension DataSourceTester {
    func assertNotCalled(collectionView: GeneralCollectionView) { }
    func cleanUp() { }
}
