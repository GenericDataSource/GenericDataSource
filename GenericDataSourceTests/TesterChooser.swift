//
//  TesterChooser.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation
import GenericDataSource

struct ChosenTester {
    let useFirst: Bool
    let localIndexPath: IndexPath
}

protocol TesterChooser {
    func choose(tester1: AbstractDataSource, tester2: AbstractDataSource, dataSource: CompositeDataSource, indexPath: IndexPath, collectionView: GeneralCollectionView) -> ChosenTester
}

struct DefaulTesterChooser: TesterChooser {
    func choose(tester1: AbstractDataSource, tester2: AbstractDataSource, dataSource: CompositeDataSource, indexPath: IndexPath, collectionView: GeneralCollectionView) -> ChosenTester {
        switch dataSource.sectionType {
        case .single:
            let indexPath2 = IndexPath(item: indexPath.item - tester1.ds_numberOfItems(inSection: 0), section: indexPath.section)
            return indexPath2.item < 0 ? ChosenTester(useFirst: true, localIndexPath: indexPath) : ChosenTester(useFirst: false, localIndexPath: indexPath2)
        case .multi:
            let indexPath2 = IndexPath(item: indexPath.item, section: indexPath.section - 1)
            return indexPath2.section < 0 ? ChosenTester(useFirst: true, localIndexPath: indexPath) : ChosenTester(useFirst: false, localIndexPath: indexPath2)
        }
    }
}

struct FirstSingleSectionTesterChooser: TesterChooser {
    func choose(tester1: AbstractDataSource, tester2: AbstractDataSource, dataSource: CompositeDataSource, indexPath: IndexPath, collectionView: GeneralCollectionView) -> ChosenTester {
        switch dataSource.sectionType {
        case .single:
            return ChosenTester(useFirst: true, localIndexPath: indexPath)
        case .multi:
            let indexPath2 = IndexPath(item: indexPath.item, section: indexPath.section - 1)
            return indexPath2.section < 0 ? ChosenTester(useFirst: true, localIndexPath: indexPath) : ChosenTester(useFirst: false, localIndexPath: indexPath2)
        }
    }
}

struct AlwaysFirstTesterChooser: TesterChooser {
    func choose(tester1: AbstractDataSource, tester2: AbstractDataSource, dataSource: CompositeDataSource, indexPath: IndexPath, collectionView: GeneralCollectionView) -> ChosenTester {
        return ChosenTester(useFirst: true, localIndexPath: indexPath)
    }
}
