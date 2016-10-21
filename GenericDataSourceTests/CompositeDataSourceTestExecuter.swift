//
//  CompositeDataSourceTestExecuter.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/21/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import  GenericDataSource

protocol CompositeDataSourceTestExecuter {
    func execute<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        tester1: Tester1,
        tester2: Tester2,
        indexPath: IndexPath,
        collectionView: GeneralCollectionView,
        dataSource: CompositeDataSource)
    where Tester1.Result == Tester2.Result
}

struct DefaultCompositeDataSourceTestExecuter: CompositeDataSourceTestExecuter {

    func execute<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        tester1: Tester1,
        tester2: Tester2,
        indexPath: IndexPath,
        collectionView: GeneralCollectionView,
        dataSource: CompositeDataSource)
        where Tester1.Result == Tester2.Result {

            func calculateLocalIndexPath() -> (IndexPath, Bool) {
                switch dataSource.sectionType {
                case .single:
                    let indexPath2 = IndexPath(item: indexPath.item - tester1.dataSource.ds_numberOfItems(inSection: 0), section: indexPath.section)
                    return indexPath2.item < 0 ? (indexPath, true) : (indexPath2, false)
                case .multi:
                    let indexPath2 = IndexPath(item: indexPath.item, section: indexPath.section - 1)
                    return indexPath2.section < 0 ? (indexPath, true) : (indexPath2, false)
                }
            }

            let result = tester1.test(indexPath: indexPath, dataSource: dataSource, generalCollectionView: collectionView)
            let (localIndexPath, useFirst) = calculateLocalIndexPath()
            if useFirst {
                tester2.assertNotCalled(collectionView: collectionView)
                tester1.assert(result: result, indexPath: localIndexPath, collectionView: collectionView)
            } else {
                tester1.assertNotCalled(collectionView: collectionView)
                tester2.assert(result: result, indexPath: localIndexPath, collectionView: collectionView)
            }
            tester1.cleanUp()
            tester2.cleanUp()
    }
}
