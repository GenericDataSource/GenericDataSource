//
//  TestData.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

@testable import GenericDataSource

public struct Report : Equatable {

    var id: Int
    var name: String
}

public func ==(lhs: Report, rhs: Report) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}

public protocol ReportCell {

    var reports: [Report] { set get }
    var indexPaths: [NSIndexPath] { set get }
    func configureForReport(report: Report, indexPath: NSIndexPath)
}

class TextReportTableViewCell: UITableViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [NSIndexPath] = []

    func configureForReport(report: Report, indexPath: NSIndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class TextReportCollectionViewCell: UICollectionViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [NSIndexPath] = []

    func configureForReport(report: Report, indexPath: NSIndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class PDFReportTableViewCell: UITableViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [NSIndexPath] = []

    func configureForReport(report: Report, indexPath: NSIndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class PDFReportCollectionViewCell: UICollectionViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [NSIndexPath] = []

    func configureForReport(report: Report, indexPath: NSIndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class ReportBasicDataSource<CellType where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject>: BasicDataSource<Report, CellType> {

    init() {
        super.init(reuseIdentifier: NSStringFromClass(CellType.self))
    }

    func registerReusableViewsInCollectionView(collectionView: CollectionView) {
        collectionView.registerClass(CellType.self, forCellWithReuseIdentifier: NSStringFromClass(CellType.self))
    }

    override func configure(collectionView collectionView: CollectionView, cell: CellType, item: Report, indexPath: NSIndexPath) {
        cell.configureForReport(item, indexPath: indexPath)
    }
}

class ReportNoReuseBasicDataSource<CellType where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject>: BasicDataSource<Report, CellType> {

    init() {
        super.init(reuseIdentifier: "")
    }
    
    override func ds_collectionView(collectionView: CollectionView, nonConfiguredCellForItemAtIndexPath indexPath: NSIndexPath) -> CellType {
        return CellType.init()
    }
}

class ReportBasicBlockDataSource<CellType where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject>: BasicBlockDataSource<Report, CellType> {

    init(configureBlock: ConfigureBlock) {
        super.init(reuseIdentifier: NSStringFromClass(CellType.self), configureBlock: configureBlock)
    }

    func registerReusableViewsInCollectionView(collectionView: CollectionView) {
        collectionView.registerClass(CellType.self, forCellWithReuseIdentifier: NSStringFromClass(CellType.self))
    }
}