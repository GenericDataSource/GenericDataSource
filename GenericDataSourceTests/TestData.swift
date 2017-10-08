//
//  TestData.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit
import GenericDataSource

public struct Report: Equatable {

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

public func == (lhs: Report, rhs: Report) -> Bool {
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

class ReportTableHeaderFooterView: UITableViewHeaderFooterView, ReportCell {

    var reports: [Report] = []
    var indexPaths: [IndexPath] = []

    func configureForReport(_ report: Report, indexPath: IndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class ReportCollectionReusableView: UICollectionReusableView, ReportCell {

    var reports: [Report] = []
    var indexPaths: [IndexPath] = []

    func configureForReport(_ report: Report, indexPath: IndexPath) {
        reports.append(report)
        indexPaths.append(indexPath)
    }
}

class ReportBasicDataSource<CellType>: BasicDataSource<Report, CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override init() {
        super.init()
    }

    func registerReusableViewsInCollectionView(_ collectionView: GeneralCollectionView) {
        collectionView.ds_register(cellClass: CellType.self)
    }

    override func ds_collectionView(
        _ collectionView: GeneralCollectionView,
        configure cell: CellType,
        with item: Report,
        at indexPath: IndexPath) {
        cell.configureForReport(item, indexPath: indexPath)
    }
}

class ReportNoReuseBasicDataSource<CellType>: BasicDataSource<Report, CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, dequeueCellForItemAt indexPath: IndexPath) -> CellType {
        return CellType.init()
    }
}

class ReportBasicBlockDataSource<CellType>: BasicBlockDataSource<Report, CellType> where CellType: ReportCell, CellType: ReusableCell, CellType: NSObject {

    func registerReusableViewsInCollectionView(_ collectionView: GeneralCollectionView) {
        collectionView.ds_register(cellClass: CellType.self)
    }
}

class ReportBasicSupplementaryViewCreator<SupplementaryView: ReusableSupplementaryView>: BasicSupplementaryViewCreator<Report, SupplementaryView>
    where SupplementaryView: NSObject, SupplementaryView: ReportCell {

    var kind: String?

    func registerReusableViewsInCollectionView(_ collectionView: GeneralCollectionView) {
        if let tableView = collectionView as? UITableView {
            tableView.ds_register(headerFooterClass: SupplementaryView.self as! UITableViewHeaderFooterView.Type)
        } else if let collectionView = collectionView as? UICollectionView {
            collectionView.ds_register(supplementaryViewNib: SupplementaryView.self as! UICollectionViewCell.Type, forKind: kind!)
        }
    }

    override func collectionView(_ collectionView: GeneralCollectionView, configure view: SupplementaryView, with item: Report, at indexPath: IndexPath) {
        view.configureForReport(item, indexPath: indexPath)
    }
}
