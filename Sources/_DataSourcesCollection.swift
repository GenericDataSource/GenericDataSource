//
//  DataSourcesCollection.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/21/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

private class _DataSourceWrapper : Hashable {
    let dataSource: DataSource
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    var hashValue: Int {
        return Unmanaged.passUnretained(dataSource).toOpaque().hashValue
    }
}

private func ==(lhs: _DataSourceWrapper, rhs: _DataSourceWrapper) -> Bool {
    return lhs.dataSource === rhs.dataSource
}

struct _MappingCollection: MutableCollection, RangeReplaceableCollection {

    typealias Element = _DataSourcesCollectionMapping
    typealias Index = Int
    typealias SubSequence = ArraySlice<Element>

    private var array: [Element] = []
    fileprivate var dataSourceToMappings: [_DataSourceWrapper: Element] = [:]

    /// Always zero, just like `endIndex`.
    var startIndex: Index { return array.startIndex }

    /// Always zero, just like `startIndex`.
    var endIndex: Index { return array.endIndex }

    subscript(position: Index) -> Element {
        get { return array[position] }
        set { array[position] = newValue }
    }

    subscript(bounds: Range<Index>) -> SubSequence {
        get { return array[bounds] }
        set { array[bounds] = newValue }
    }

    func index(after i: Int) -> Int { return array.index(after: i) }

    mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: C) where C : Collection, C.Iterator.Element == Element {
        array.replaceSubrange(subrange, with: newElements)
    }
}

protocol _DataSourcesCollection: NSObjectProtocol {
    unowned var parentDataSource: CompositeDataSource { get }
    var mappings: _MappingCollection { get set }

    func add(_ dataSource: DataSource)
    func insert(_ dataSource: DataSource, at index: Int)
    func remove(_ dataSource: DataSource)
    func remove(at index: Int) -> DataSource
    func removeAllDataSources()
    func dataSource(at index: Int) -> DataSource
    func contains(_ dataSource: DataSource) -> Bool
    func index(of dataSource: DataSource) -> Int?

    func mapping(of dataSource: DataSource) -> _DataSourcesCollectionMapping?

    func globalIndexPathForLocalIndexPath(_ indexPath: IndexPath, dataSource: DataSource) -> IndexPath
    func globalSectionForLocalSection(_ localSection: Int, dataSource: DataSource) -> Int
    func localIndexPathForGlobalIndexPath(_ indexPath: IndexPath, dataSource: DataSource) -> IndexPath
    func localSectionForGlobalSection(_ section: Int, dataSource: DataSource) -> Int

    func unsafeTransform(globalIndexPath: IndexPath, globalCollectionView: GeneralCollectionView) -> LocalDataSourceCollectionView
    func transform(globalIndexPath: IndexPath, globalCollectionView: GeneralCollectionView) -> LocalDataSourceCollectionView?

    // MARK:- Subclassing

    func createMapping(for dataSource: DataSource) -> _DataSourcesCollectionMapping

    func updateMappings()

    func mapping(for indexPath: IndexPath) -> _DataSourcesCollectionMapping?

    func numberOfSections() -> Int

    func numberOfItems(inSection section: Int) -> Int
}

extension _DataSourcesCollection {

    var dataSources: [DataSource] {
        return mappings.map { $0.dataSource }
    }

    private func createAndPrepareMapping(for dataSource: DataSource) -> _DataSourcesCollectionMapping {

        guard (dataSource as? CompositeDataSource)?.sectionType != .multi else {
            fatalError("Cannot add a multi-section composite data source as child data source. It should be at the top level of the hierarchy.")
        }

        let wrapper = _DataSourceWrapper(dataSource: dataSource)
        let existingMapping = mappings.dataSourceToMappings[wrapper]
        assert(existingMapping == nil, "Tried to add a data source more than once: \(dataSource)")

        let mapping = createMapping(for: dataSource)
        mappings.dataSourceToMappings[wrapper] = mapping

        let collectionMapping = _CompositeParentGeneralCollectionViewMapping(dataSource: dataSource, parentDataSource: parentDataSource)
        let delegate = _DelegatedGeneralCollectionView(mapping: collectionMapping)
        // retain it
        mapping.reusableDelegate = delegate
        dataSource.ds_reusableViewDelegate = delegate

        return mapping
    }

    // MARK: API

    func add(_ dataSource: DataSource) {

        let mapping = createAndPrepareMapping(for: dataSource)
        mappings.append(mapping)

        // update the mapping
        updateMappings()
    }

    func insert(_ dataSource: DataSource, at index: Int) {

        assert(index >= 0 && index <= mappings.count, "Invalid index \(index) should be between [0..\(mappings.count)")

        let mapping = createAndPrepareMapping(for: dataSource)
        mappings.insert(mapping, at: index)

        // update the mapping
        updateMappings()
    }

    func remove(_ dataSource: DataSource) {

        let wrapper = _DataSourceWrapper(dataSource: dataSource)
        let exsitingMapping: _DataSourcesCollectionMapping = cast(mappings.dataSourceToMappings[wrapper], message: "Tried to remove a data source that doesn't exist: \(dataSource)")
        let index: Int = cast(mappings.index(of: exsitingMapping), message: "Tried to remove a data source that doesn't exist: \(dataSource)")

        mappings.dataSourceToMappings[wrapper] = nil
        mappings.remove(at: index)

        // update the mapping
        updateMappings()
    }

    func remove(at index: Int) -> DataSource {

        let dataSource = mappings[index].dataSource
        mappings.dataSourceToMappings[_DataSourceWrapper(dataSource: dataSource)] = nil
        mappings.remove(at: index)

        // update the mapping
        updateMappings()
        return dataSource
    }

    func removeAllDataSources() {
        mappings.dataSourceToMappings.removeAll()
        mappings.removeAll()

        // update the mapping
        updateMappings()
    }

    func dataSource(at index: Int) -> DataSource {
        return mappings[index].dataSource
    }

    func contains(_ dataSource: DataSource) -> Bool {
        return mapping(of: dataSource) != nil
    }

    func index(of dataSource: DataSource) -> Int? {
        guard let mapping = mapping(of: dataSource) else {
            return nil
        }
        return mappings.index(of: mapping)
    }

    func mapping(of dataSource: DataSource) -> _DataSourcesCollectionMapping? {
        let wrapper = _DataSourceWrapper(dataSource: dataSource)
        let existingMapping = mappings.dataSourceToMappings[wrapper]
        return existingMapping
    }

    func globalIndexPathForLocalIndexPath(_ indexPath: IndexPath, dataSource: DataSource) -> IndexPath {
        let mapping = unsafeMapping(of: dataSource)
        return mapping.globalIndexPathForLocalIndexPath(indexPath)
    }

    func globalSectionForLocalSection(_ localSection: Int, dataSource: DataSource) -> Int {
        let mapping = unsafeMapping(of: dataSource)
        return mapping.globalSectionForLocalSection(localSection)
    }

    func localIndexPathForGlobalIndexPath(_ indexPath: IndexPath, dataSource: DataSource) -> IndexPath {
        let mapping = unsafeMapping(of: dataSource)
        return mapping.localIndexPathForGlobalIndexPath(indexPath)
    }

    func localSectionForGlobalSection(_ section: Int, dataSource: DataSource) -> Int {
        let mapping: _DataSourcesCollectionMapping = cast(self.mapping(of: dataSource), message: "dataSource is not a child to composite data source")
        return mapping.localSectionForGlobalSection(section)
    }

    func unsafeTransform(globalIndexPath: IndexPath, globalCollectionView: GeneralCollectionView) -> LocalDataSourceCollectionView {
        let mapping: LocalDataSourceCollectionView = cast(transform(globalIndexPath: globalIndexPath, globalCollectionView: globalCollectionView),
                                                          message: "unsafeTransform called but there is no mapping possible for the passed index path.")
        return mapping
    }

    func transform(globalIndexPath: IndexPath, globalCollectionView: GeneralCollectionView) -> LocalDataSourceCollectionView? {
        updateMappings()

        guard let mapping = mapping(for: globalIndexPath) else { return nil }
        let localIndexPath = mapping.localIndexPathForGlobalIndexPath(globalIndexPath)

        let wrapperMapping = _GeneralCollectionViewWrapperMapping(mapping: mapping, view: globalCollectionView)
        let wrapperView = _DelegatedGeneralCollectionView(mapping: wrapperMapping)

        return LocalDataSourceCollectionView(dataSource: mapping.dataSource, collectionView: wrapperView, indexPath: localIndexPath)
    }

    private func unsafeMapping(of dataSource: DataSource) -> _DataSourcesCollectionMapping {
        let mapping: _DataSourcesCollectionMapping = cast(self.mapping(of: dataSource), message: "dataSource is not a child to composite data source")
        return mapping
    }
}

class _DataSourcesCollectionMapping : Equatable {

    /// retained
    var reusableDelegate: _DelegatedGeneralCollectionView?

    let dataSource: DataSource

    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    func localItemForGlobalItem(_ globalItem: Int) -> Int {
        return globalItem
    }

    func globalItemForLocalItem(_ localItem: Int) -> Int {
        return localItem
    }

    func localSectionForGlobalSection(_ globalSection: Int) -> Int {
        return globalSection
    }

    func globalSectionForLocalSection(_ localSection: Int) -> Int {
        return localSection
    }

    func localIndexPathForGlobalIndexPath(_ globalIndexPath: IndexPath) -> IndexPath {
        let localItem = localItemForGlobalItem(globalIndexPath.item)
        let localSection = localSectionForGlobalSection(globalIndexPath.section)
        return IndexPath(item: localItem, section: localSection)
    }

    func globalIndexPathForLocalIndexPath(_ localIndexPath: IndexPath) -> IndexPath {
        let globalItem = globalItemForLocalItem(localIndexPath.item)
        let globalSection = globalSectionForLocalSection(localIndexPath.section)
        return IndexPath(item: globalItem, section: globalSection)
    }
}

func ==(lhs: _DataSourcesCollectionMapping, rhs: _DataSourcesCollectionMapping) -> Bool {
    return lhs === rhs
}
