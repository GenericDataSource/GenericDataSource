//
//  CompositeDataSourceSpecificTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class CompositeDataSourceSpecificTests: XCTestCase {

    func testRespondsToForSizeForItemAtIndexPath() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        let ds: AnyObject = dataSource
        XCTAssertFalse(ds.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertFalse(ds.responds(to: #selector(UITableViewDelegate.tableView(_:heightForRowAt:))))

        pdfReportsDataSource.itemSize = CGSize(width: 1, height: 1)
        textReportsDataSource.itemSize = CGSize(width: 1, height: 1)

        XCTAssertTrue(ds.responds(to: #selector(DataSource.ds_collectionView(_:sizeForItemAt:))))
        XCTAssertTrue(ds.responds(to: #selector(UITableViewDelegate.tableView(_:heightForRowAt:))))
    }

    func testRemoveAllDataSourcesSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)

        // test
        dataSource.removeAllDataSources()
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testRemoveAllDataSourcesMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)

        dataSource.removeAllDataSources()
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testAddSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
    }

    func testAddMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
    }

    func testInsertDataSourceSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.insert(pdfReportsDataSource, at: 0)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.insert(textReportsDataSource, at: 0)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[1])
    }

    func testInsertDataSourceMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.insert(pdfReportsDataSource, at: 0)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.insert(textReportsDataSource, at: 0)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[1])
    }

    func testRemoveSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        dataSource.remove(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])

        dataSource.remove(textReportsDataSource)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testRemoveMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        dataSource.remove(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])

        dataSource.remove(textReportsDataSource)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testRemoveAtSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        dataSource.remove(at: 0)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])

        dataSource.remove(at: 0)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testRemoveAtMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        dataSource.remove(at: 0)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])

        dataSource.remove(at: 0)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testDataSourceAtIndexSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSource(at: 0))
        XCTAssertTrue(textReportsDataSource === dataSource.dataSource(at: 1))
    }

    func testDataSourceAtIndexMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSource(at: 0))
        XCTAssertTrue(textReportsDataSource === dataSource.dataSource(at: 1))
    }

    func testContainsDataSourceSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertTrue(dataSource.contains(pdfReportsDataSource))
        XCTAssertTrue(dataSource.contains(textReportsDataSource))
        XCTAssertFalse(dataSource.contains(ReportBasicDataSource<PDFReportCollectionViewCell>()))
    }

    func testContainsDataSourceMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertTrue(dataSource.contains(pdfReportsDataSource))
        XCTAssertTrue(dataSource.contains(textReportsDataSource))
        XCTAssertFalse(dataSource.contains(ReportBasicDataSource<PDFReportCollectionViewCell>()))
    }

    func testIndexOfDataSourceSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.index(of: pdfReportsDataSource))
        XCTAssertEqual(1, dataSource.index(of: textReportsDataSource))
        XCTAssertNil(dataSource.index(of: ReportBasicDataSource<PDFReportCollectionViewCell>()))
    }

    func testIndexOfDataSourceMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.index(of: pdfReportsDataSource))
        XCTAssertEqual(1, dataSource.index(of: textReportsDataSource))
        XCTAssertNil(dataSource.index(of: ReportBasicDataSource<PDFReportCollectionViewCell>()))
    }

    func testGlobalSectionForLocalSectionSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.globalSectionForLocalSection(0, dataSource: pdfReportsDataSource))
        XCTAssertEqual(5, dataSource.globalSectionForLocalSection(5, dataSource: pdfReportsDataSource))
        XCTAssertEqual(0, dataSource.globalSectionForLocalSection(0, dataSource: textReportsDataSource))
        XCTAssertEqual(5, dataSource.globalSectionForLocalSection(5, dataSource: textReportsDataSource))
    }

    func testGlobalSectionForLocalSectionMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.globalSectionForLocalSection(0, dataSource: pdfReportsDataSource))
        XCTAssertEqual(1, dataSource.globalSectionForLocalSection(0, dataSource: textReportsDataSource))
    }

    func testLocalSectionForGlobalSectionSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.localSectionForGlobalSection(0, dataSource: pdfReportsDataSource))
        XCTAssertEqual(5, dataSource.localSectionForGlobalSection(5, dataSource: pdfReportsDataSource))
        XCTAssertEqual(0, dataSource.localSectionForGlobalSection(0, dataSource: textReportsDataSource))
        XCTAssertEqual(5, dataSource.localSectionForGlobalSection(5, dataSource: textReportsDataSource))
    }

    func testLocalSectionForGlobalSectionMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.localSectionForGlobalSection(0, dataSource: pdfReportsDataSource))
        XCTAssertEqual(0, dataSource.localSectionForGlobalSection(1, dataSource: textReportsDataSource))
    }

    func testGlobalIndexPathForLocalIndexPathSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(IndexPath(item: 0, section: 0),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 0, section: 0), dataSource: pdfReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 5, section: 9), dataSource: pdfReportsDataSource))

        XCTAssertEqual(IndexPath(item: 50, section: 0),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 0, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 55, section: 9),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 5, section: 9), dataSource: textReportsDataSource))
    }

    func testGlobalIndexPathForLocalIndexPathMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(IndexPath(item: 0, section: 0),
                       dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 0, section: 0), dataSource: pdfReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 0),
                       dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 5, section: 0), dataSource: pdfReportsDataSource))

        XCTAssertEqual(IndexPath(item: 50, section: 1),
                       dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 50, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 55, section: 1),
                       dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 55, section: 0), dataSource: textReportsDataSource))
    }

    func testLocalIndexPathForGlobalIndexPathSingle() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(IndexPath(item: 0, section: 0),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 0, section: 0), dataSource: pdfReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 5, section: 9), dataSource: pdfReportsDataSource))

        XCTAssertEqual(IndexPath(item: 0, section: 0),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 50, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 55, section: 9), dataSource: textReportsDataSource))
    }

    func testLocalIndexPathForGlobalIndexPathMulti() {

        let dataSource  = CompositeDataSource(sectionType: .multi)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(IndexPath(item: 0, section: 0),
                       dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 0, section: 0), dataSource: pdfReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 0),
                       dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 5, section: 0), dataSource: pdfReportsDataSource))

        XCTAssertEqual(IndexPath(item: 50, section: 0),
                       dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 50, section: 1), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 55, section: 0),
                       dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 55, section: 1), dataSource: textReportsDataSource))
    }

    // MARK: - Cells, Number of Items, Number of sections

    func testOneDataSourceSingleSectionTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let reportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports

        let dataSource  = CompositeDataSource(sectionType: .single)
        dataSource.add(reportsDataSource)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        reportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(reportsDataSource === dataSource.dataSources[0])
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(reports.count, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testOneDataSourceMultiSectionTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let reportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(reportsDataSource)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        reportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(reportsDataSource === dataSource.dataSources[0])
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(reports.count, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0] as! [TextReportTableViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testOneDataSourceSingleSectionCollectionView() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let reportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports

        let dataSource  = CompositeDataSource(sectionType: .single)
        dataSource.add(reportsDataSource)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        reportsDataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(reportsDataSource === dataSource.dataSources[0])
        XCTAssertEqual(1, collectionView.numberOfSections)
        XCTAssertEqual(reports.count, collectionView.numberOfItems(inSection: 0))
        let cells = collectionView.cells[0] as! [TextReportCollectionViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")

        }
    }

    func testOneDataSourceMultiSectionCollectionView() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let reportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(reportsDataSource)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        reportsDataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(reportsDataSource === dataSource.dataSources[0])
        XCTAssertEqual(1, collectionView.numberOfSections)
        XCTAssertEqual(reports.count, collectionView.numberOfItems(inSection: 0))
        let cells = collectionView.cells[0] as! [TextReportCollectionViewCell]

        for (index, cell) in cells.enumerated() {
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testMultipleDataSourcesSingleSectionTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let dataSource  = CompositeDataSource(sectionType: .single)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(total, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0]

        for (index, cell) in cells.enumerated() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index - total / 2, section: 0)), "Invalid index path at index: \(index)")
            }
        }
    }

    func testMultipleDataSourcesSingleSectionCollectionView() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let dataSource  = CompositeDataSource(sectionType: .single)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(collectionView)
        textReportsDataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
        XCTAssertEqual(1, collectionView.numberOfSections)
        XCTAssertEqual(total, collectionView.numberOfItems(inSection: 0))
        let cells = collectionView.cells[0]

        for (index, cell) in cells.enumerated() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportCollectionViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportCollectionViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index - total / 2, section: 0)), "Invalid index path at index: \(index)")
            }
        }
    }

    func testMultipleDataSourcesMultiSectionTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
        XCTAssertEqual(2, tableView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 1))

        let cells1 = tableView.cells[0]
        for (index, cell) in cells1.enumerated() {
            guard let cell = cell as? PDFReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }

        let cells2 = tableView.cells[1]
        for (index, cell) in cells2.enumerated() {
            guard let cell = cell as? TextReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1 + total / 2, name: "text report-\(index + 1 + total / 2)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testMultipleDataSourcesMultiSectionCollectionView() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(collectionView)
        textReportsDataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
        XCTAssertEqual(2, collectionView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count, collectionView.numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource.items.count, collectionView.numberOfItems(inSection: 1))

        let cells1 = collectionView.cells[0]
        for (index, cell) in cells1.enumerated() {
            guard let cell = cell as? PDFReportCollectionViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }

        let cells2 = collectionView.cells[1]
        for (index, cell) in cells2.enumerated() {
            guard let cell = cell as? TextReportCollectionViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1 + total / 2, name: "text report-\(index + 1 + total / 2)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testMultipleDataSourcesSingleAndMultiTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportTableViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let singleSectionDataSource  = CompositeDataSource(sectionType: .single)
        singleSectionDataSource.add(pdfReportsDataSource)
        singleSectionDataSource.add(textReportsDataSource)

        let textReportsDataSource2 = ReportBasicDataSource<TextReportTableViewCell>()
        textReportsDataSource2.items = Report.generate(numberOfReports: total, name: "another report")

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(singleSectionDataSource)
        dataSource.add(textReportsDataSource2)

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(singleSectionDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource2 === dataSource.dataSources[1])
        XCTAssertEqual(2, tableView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count + textReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource2.items.count, tableView.ds_numberOfItems(inSection: 1))
        let cells1 = tableView.cells[0]

        for (index, cell) in cells1.enumerated() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportTableViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index - total / 2, section: 0)), "Invalid index path at index: \(index)")
            }
        }

        let cells2 = tableView.cells[1]
        for (index, cell) in cells2.enumerated() {
            guard let cell = cell as? TextReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "another report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testMultipleDataSourcesSingleAndMultiCollectionView() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let singleSectionDataSource  = CompositeDataSource(sectionType: .single)
        singleSectionDataSource.add(pdfReportsDataSource)
        singleSectionDataSource.add(textReportsDataSource)

        let textReportsDataSource2 = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource2.items = Report.generate(numberOfReports: total, name: "another report")

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(singleSectionDataSource)
        dataSource.add(textReportsDataSource2)

        // assign as data source
        collectionView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(collectionView)
        textReportsDataSource.registerReusableViewsInCollectionView(collectionView)

        // execute the test
        collectionView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(singleSectionDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource2 === dataSource.dataSources[1])
        XCTAssertEqual(2, collectionView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count + textReportsDataSource.items.count, collectionView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource2.items.count, collectionView.ds_numberOfItems(inSection: 1))
        let cells1 = collectionView.cells[0]

        for (index, cell) in cells1.enumerated() {
            if index < total / 2 {
                guard let cell = cell as? PDFReportCollectionViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
            } else {
                guard let cell = cell as? TextReportCollectionViewCell else {
                    XCTFail("Invalid cell type at index: \(index)")
                    return
                }
                XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
                XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index - total / 2, section: 0)), "Invalid index path at index: \(index)")
            }
        }

        let cells2 = collectionView.cells[1]
        for (index, cell) in cells2.enumerated() {
            guard let cell = cell as? TextReportCollectionViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "another report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
        }
    }

    func testSupplmentaryViews() {

        let collectionView = MockCollectionView()
        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(from: total / 2 + 1, numberOfReports: total, name: "text report")

        let dataSource  = CompositeDataSource(sectionType: .multi)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        let creator = MockSupplementaryViewCreator()
        let creator1 = MockSupplementaryViewCreator()
        let creator2 = MockSupplementaryViewCreator()

        dataSource.supplementaryViewCreator = creator
        pdfReportsDataSource.supplementaryViewCreator = creator1
        textReportsDataSource.supplementaryViewCreator = creator2

        creator.view = UICollectionReusableView()
        creator.size = CGSize(width: 19, height: 45)

        let indexPath = IndexPath(item: 10, section: 10)

        // view
        let view = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionElementKindSectionHeader, at: indexPath)
        XCTAssertEqual(creator.view as? UIView, view)
        XCTAssertEqual(indexPath, creator.indexPath)
        XCTAssertEqual(UICollectionElementKindSectionHeader, creator.kind)

        // size
        let size = dataSource.collectionView(collectionView, layout: UICollectionViewFlowLayout(), referenceSizeForFooterInSection: indexPath.section)
        XCTAssertEqual(creator.size, size)
        XCTAssertEqual(indexPath.section, creator.indexPath?.section)

        // will display
        dataSource.collectionView(collectionView, willDisplaySupplementaryView: UICollectionReusableView(), forElementKind: UICollectionElementKindSectionFooter, at: indexPath)
        XCTAssertTrue(creator.willDisplayCalled)

        // did display
        dataSource.collectionView(collectionView, didEndDisplayingSupplementaryView: UICollectionReusableView(), forElementOfKind: UICollectionElementKindSectionHeader, at: indexPath)
        XCTAssertTrue(creator.didDisplayCalled)
    }

    func testSupplementaryOutsideRange() {
        let dataSource = CompositeDataSource(sectionType: .multi)

        let size = dataSource.collectionView(MockCollectionView(), layout: UICollectionViewFlowLayout(), referenceSizeForHeaderInSection: 2)
        XCTAssertEqual(CGSize.zero, size)
    }
}
