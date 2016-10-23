//
//  CompositeDataSourceTestExecutor.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/21/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import  GenericDataSource

protocol CompositeDataSourceTestExecutor {
    func execute<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        tester1: Tester1,
        tester2: Tester2,
        indexPath: IndexPath,
        collectionView: GeneralCollectionView,
        dataSource: CompositeDataSource)
    where Tester1.Result == Tester2.Result
}

struct DefaultCompositeDataSourceTestExecutor: CompositeDataSourceTestExecutor {

    let chooser: TesterChooser

    func execute<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        tester1: Tester1,
        tester2: Tester2,
        indexPath: IndexPath,
        collectionView: GeneralCollectionView,
        dataSource: CompositeDataSource)
        where Tester1.Result == Tester2.Result {

            let chosen = chooser.choose(tester1: tester1.dataSource, tester2: tester2.dataSource, dataSource: dataSource, indexPath: indexPath, collectionView: collectionView)
            if chosen.useFirst {
                test(tester1: tester1, tester2: tester2, indexPath: indexPath, localIndexPath: chosen.localIndexPath, collectionView: collectionView, dataSource: dataSource)
            } else {
                test(tester1: tester2, tester2: tester1, indexPath: indexPath, localIndexPath: chosen.localIndexPath, collectionView: collectionView, dataSource: dataSource)
            }
    }

    private func test<Tester1: DataSourceTester, Tester2: DataSourceTester>(
        tester1: Tester1,
        tester2: Tester2,
        indexPath: IndexPath,
        localIndexPath: IndexPath,
        collectionView: GeneralCollectionView,
        dataSource: CompositeDataSource) {

        // test
        let result = tester1.test(indexPath: indexPath, dataSource: dataSource, generalCollectionView: collectionView)

        // assert
        tester2.assertNotCalled(collectionView: collectionView)
        tester1.assert(result: result, indexPath: localIndexPath, collectionView: collectionView)

        // cleanup
        tester1.cleanUp()
        tester2.cleanUp()
    }
}
