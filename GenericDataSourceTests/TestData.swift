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
    
    public static func generate(from: Int = 1, numberOfReports: Int, name: String = "report") -> [Report] {
        var reports: [Report] = []
        for i in from...numberOfReports {
            reports.append(Report(id: i, name: "\(name)-\(i)"))
        }
        return reports
    }
}

public func ==(lhs: Report, rhs: Report) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}

public protocol ReportCell {

    var reports: [Report] { set get }
    var indexPaths: [IndexPath] { set get }
    func configureForReport(_ report: Report, indexPath: IndexPath)
}

class TextReportTableViewCell: UITableViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [IndexPath] = []

    func configureForReport(_ report: Report, indexPath: IndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class TextReportCollectionViewCell: UICollectionViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [IndexPath] = []

    func configureForReport(_ report: Report, indexPath: IndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class PDFReportTableViewCell: UITableViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [IndexPath] = []

    func configureForReport(_ report: Report, indexPath: IndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class PDFReportCollectionViewCell: UICollectionViewCell, ReportCell {

    var reports: [Report] = []
    var indexPaths: [IndexPath] = []

    func configureForReport(_ report: Report, indexPath: IndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class ReportBasicDataSource<CellType>: BasicDataSource<Report, CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    init() {
        super.init(reuseIdentifier: NSStringFromClass(CellType.self))
    }

    func registerReusableViewsInCollectionView(_ collectionView: GeneralCollectionView) {
        collectionView.ds_registerClass(CellType.self, forCellWithReuseIdentifier: NSStringFromClass(CellType.self))
    }

    override func ds_collectionView(
        _ collectionView: GeneralCollectionView,
        configureCell cell: CellType,
        withItem item: Report,
        atIndexPath indexPath: IndexPath) {
        cell.configureForReport(item, indexPath: indexPath)
    }
}

class ReportNoReuseBasicDataSource<CellType>: BasicDataSource<Report, CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    init() {
        super.init(reuseIdentifier: "")
    }
    
    override func ds_collectionView(_ collectionView: GeneralCollectionView, dequeueCellForItemAtIndexPath indexPath: IndexPath) -> CellType {
        return CellType.init()
    }
}

class ReportBasicBlockDataSource<CellType>: BasicBlockDataSource<Report, CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    init(configureBlock: ConfigureBlock) {
        super.init(reuseIdentifier: NSStringFromClass(CellType.self), configureBlock: configureBlock)
    }

    func registerReusableViewsInCollectionView(_ collectionView: GeneralCollectionView) {
        collectionView.ds_registerClass(CellType.self, forCellWithReuseIdentifier: NSStringFromClass(CellType.self))
    }
}
