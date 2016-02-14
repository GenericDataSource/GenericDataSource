//
//  SingleSectionDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

public class SingleSectionDataSource: CompositionDataSource {

    private var itemsCount: Int = 0

    private var globalItemToMappings: [Int: SingleSectionMapping] = [:]

    override func createMappingForDataSource(dataSource: DataSource) -> CompositionDataSource.Mapping {
        return SingleSectionMapping(dataSource: dataSource)
    }

    override func updateMappings() {

        // reset
        var count = 0
        globalItemToMappings.removeAll()

        for mapping in mappings {
            guard let mapping = mapping as? SingleSectionMapping else {
                fatalError("Mappings for \(self.dynamicType) should be of type \(SingleSectionMapping.self)")
            }

            let newItemCount = mapping.updateMappings(startingWithGlobalItem: count) + count
            while (count < newItemCount) {
                globalItemToMappings[count++] = mapping
            }
        }
        itemsCount = count
    }

    override func mappingForIndexPath(indexPath: NSIndexPath) -> Mapping {
        return mappingForGlobalItem(indexPath.item)
    }

    func mappingForGlobalItem(item: Int) -> SingleSectionMapping {
        guard let mapping = globalItemToMappings[item] else {
            fatalError("Couldn't find mapping for item: \(item)")
        }
        return mapping
    }

    // MARK:- Data Source

    public func numberOfSections() -> Int {
        updateMappings()

        return 1
    }

    public func numberOfItems(inSection section: Int) -> Int {
        updateMappings()
        
        return itemsCount
    }
}


extension SingleSectionDataSource {

    internal class SingleSectionMapping : Mapping {

        private var globalToLocalItems: [Int: Int] = [:]
        private var localToGlobalItems: [Int: Int] = [:]

        override func localItemForGlobalItem(globalItem: Int) -> Int {
            guard let localItem = globalToLocalItems[globalItem] else {
                fatalError("Single section: no mapping for global item: \(globalItem)")
            }
            return localItem
        }

        override func globalItemForLocalItem(localItem: Int) -> Int {
            guard let globalItem = localToGlobalItems[localItem] else {
                fatalError("Single section: no mapping for local item: \(localItem)")
            }
            return globalItem
        }

        func updateMappings(startingWithGlobalItem globalItem:Int) -> Int {

            let itemCount = self.dataSource.numberOfItems(inSection: 0)

            globalToLocalItems.removeAll()
            localToGlobalItems.removeAll()

            var mutableGlobalItem = globalItem
            for localItem in 0..<itemCount {
                addMapping(globalItem: mutableGlobalItem, localItem: localItem)
                mutableGlobalItem++
            }

            return itemCount
        }

        private func addMapping(globalItem globalItem: Int, localItem: Int) {
            assert(localToGlobalItems[localItem] == nil, "Single section: collision while trying to add mapping between Global:\(globalItem) local:\(localItem)")

            globalToLocalItems[globalItem] = localItem
            localToGlobalItems[localItem] = globalItem
        }
    }
}