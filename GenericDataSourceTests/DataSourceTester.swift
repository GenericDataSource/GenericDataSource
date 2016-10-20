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

    func test(indexPath: IndexPath, dataSource: AbstractDataSource, collectionView: GeneralCollectionView) -> Result

    func assert(result: Result, indexPath: IndexPath, collectionView: GeneralCollectionView)
    func assertNotCalled(collectionView: GeneralCollectionView)

    func cleanUp()
}

extension DataSourceTester {
    func test<T>(with collectionView: GeneralCollectionView, whenTableView: (UITableView) -> T, whenCollectionView: (UICollectionView) -> T) -> T {
        var result: T
        if let tableView = collectionView as? UITableView {
            result = whenTableView(tableView)
        } else if let collectionView = collectionView as? UICollectionView {
            result = whenCollectionView(collectionView)
        } else {
            fatalError("Test scenario error: collectionView: '\(collectionView)' should be either UITableView or UICollectionView.")
        }
        return result
    }
}

extension DataSourceTester {
    func assertNotCalled(collectionView: GeneralCollectionView) { }
    func cleanUp() { }
}
