//
//  SegmentedDataSourceTests.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/20/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class SegmentedDataSourceTests: XCTestCase {

    func testDescription() {
        class __ScrollViewDelegate: NSObject, UIScrollViewDelegate {}
        var instance = SegmentedDataSource()
        let ds = ReportBasicDataSource<PDFReportCollectionViewCell>()
        instance.add(ds)
        instance.scrollViewDelegate = __ScrollViewDelegate()
        XCTAssertTrue(instance.description.contains("SegmentedDataSource"))
        XCTAssertTrue(instance.description.contains("__ScrollViewDelegate"))
        XCTAssertTrue(instance.description.contains("scrollViewDelegate"))
        XCTAssertTrue(instance.description.contains("selectedDataSource"))
        XCTAssertTrue(instance.description.contains(ds.description))

        instance = SegmentedDataSource()
        XCTAssertTrue(instance.debugDescription.contains("SegmentedDataSource"))
        XCTAssertTrue(!instance.debugDescription.contains("scrollViewDelegate"))
        XCTAssertTrue(!instance.debugDescription.contains("selectedDataSource"))
    }

    func testSelectedDataSourceIndex() {

        let dataSource  = SegmentedDataSource()
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(NSNotFound, dataSource.selectedDataSourceIndex)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)

        dataSource.selectedDataSourceIndex = 1
        XCTAssertEqual(1, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(textReportsDataSource, dataSource.selectedDataSource)

        dataSource.selectedDataSourceIndex = 0
        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)
    }

    func testSelectedDataSource() {

        let dataSource  = SegmentedDataSource()
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()

        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(NSNotFound, dataSource.selectedDataSourceIndex)
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)

        dataSource.selectedDataSource = textReportsDataSource
        XCTAssertEqual(1, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(textReportsDataSource, dataSource.selectedDataSource)

        dataSource.selectedDataSource = pdfReportsDataSource
        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)
    }

    func testCanEditOverriden() {
        class Test: ReportBasicDataSource<TextReportCollectionViewCell> {
            override func ds_collectionView(_ collectionView: GeneralCollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
                return true
            }
        }
        class Test2: ReportBasicDataSource<TextReportCollectionViewCell> {
        }
        let ds1 = Test()
        let ds2 = Test2()

        let dataSource  = SegmentedDataSource()
        dataSource.add(ds1)
        dataSource.add(ds2)

        dataSource.selectedDataSource = ds1
        XCTAssertTrue(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:canEditItemAt:))))
        XCTAssertTrue(dataSource.ds_responds(to: .canEdit))

        let tableView = MockTableView()
        let result = dataSource.tableView(tableView, canEditRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(true, result)

        dataSource.selectedDataSource = ds2
        XCTAssertFalse(dataSource.responds(to: #selector(DataSource.ds_collectionView(_:canEditItemAt:))))
        XCTAssertFalse(dataSource.ds_responds(to: .canEdit))
    }

    func testRespondsToForSizeForItemAtIndexPath() {

        let dataSource  = SegmentedDataSource()

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

        let dataSource  = SegmentedDataSource()

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
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)
        dataSource.removeAllDataSources()
        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testAddSingle() {

        let dataSource  = SegmentedDataSource()

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)

        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(NSNotFound, dataSource.selectedDataSourceIndex)
        dataSource.add(pdfReportsDataSource)
        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)

        dataSource.add(textReportsDataSource)
        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
    }

    func testInsertDataSourceSingle() {

        let dataSource  = SegmentedDataSource()

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)

        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(NSNotFound, dataSource.selectedDataSourceIndex)
        dataSource.insert(pdfReportsDataSource, at: 0)
        XCTAssertEqual(0, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)

        dataSource.insert(textReportsDataSource, at: 0)
        XCTAssertEqual(1, dataSource.selectedDataSourceIndex)
        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[1])
    }

    func testRemoveSingle() {

        let dataSource  = SegmentedDataSource()

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)
        dataSource.remove(pdfReportsDataSource)
        XCTAssertIdentical(textReportsDataSource, dataSource.selectedDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])

        dataSource.remove(textReportsDataSource)
        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testRemoveAtSingle() {

        let dataSource  = SegmentedDataSource()

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.add(pdfReportsDataSource)

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.add(textReportsDataSource)

        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])

        XCTAssertIdentical(pdfReportsDataSource, dataSource.selectedDataSource)
        dataSource.remove(at: 0)
        XCTAssertIdentical(textReportsDataSource, dataSource.selectedDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])

        dataSource.remove(at: 0)
        XCTAssertNil(dataSource.selectedDataSource)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testDataSourceAtIndexSingle() {

        let dataSource  = SegmentedDataSource()

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

        let dataSource  = SegmentedDataSource()

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

        let dataSource  = SegmentedDataSource()

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

        let dataSource  = SegmentedDataSource()

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

    func testLocalSectionForGlobalSectionSingle() {

        let dataSource  = SegmentedDataSource()

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

    func testGlobalIndexPathForLocalIndexPathSingle() {

        let dataSource  = SegmentedDataSource()

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

        XCTAssertEqual(IndexPath(item: 0, section: 0),
                       dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 0, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
                       dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 5, section: 9), dataSource: textReportsDataSource))
    }

    func testLocalIndexPathForGlobalIndexPathSingle() {

        let dataSource  = SegmentedDataSource()

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

        XCTAssertEqual(IndexPath(item: 50, section: 0),
                       dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 50, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 55, section: 9),
                       dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 55, section: 9), dataSource: textReportsDataSource))
    }

    // MARK: - Cells, Number of Items, Number of sections

    func testOneDataSourceSingleSectionTableView() {

        let tableView = MockTableView()
        tableView.numberOfReuseCells = 10

        let reportsDataSource = ReportBasicDataSource<TextReportTableViewCell>()

        let reports = Report.generate(numberOfReports: 200)
        reportsDataSource.items = reports

        let dataSource  = SegmentedDataSource()
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

        let dataSource  = SegmentedDataSource()
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

        let dataSource  = SegmentedDataSource()
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
        XCTAssertEqual(pdfReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 0))
        let cells = tableView.cells[0]

        for (index, cell) in cells.enumerated() {
            guard let cell = cell as? PDFReportTableViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "pdf report-\(index + 1)")), "Invalid report at index: \(index)")
            XCTAssertTrue(cell.indexPaths.contains(IndexPath(item: index, section: 0)), "Invalid index path at index: \(index)")
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

        let dataSource  = SegmentedDataSource()
        dataSource.add(pdfReportsDataSource)
        dataSource.add(textReportsDataSource)
        dataSource.selectedDataSourceIndex = 1

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
        XCTAssertEqual(textReportsDataSource.ds_numberOfItems(inSection: 0), collectionView.numberOfItems(inSection: 0))
        let cells = collectionView.cells[0]

        for (index, cell) in cells.enumerated() {
            guard let cell = cell as? TextReportCollectionViewCell else {
                XCTFail("Invalid cell type at index: \(index)")
                return
            }
            XCTAssertTrue(cell.reports.contains(Report(id: index + total / 2 + 1, name: "text report-\(index + total / 2 + 1)")), "Invalid report at index: \(index)")
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

        let dataSource  = SegmentedDataSource()
        dataSource.add(textReportsDataSource2)
        dataSource.add(singleSectionDataSource)
        dataSource.selectedDataSourceIndex = 1

        // assign as data source
        tableView.dataSource = dataSource

        // register the cell
        pdfReportsDataSource.registerReusableViewsInCollectionView(tableView)
        textReportsDataSource.registerReusableViewsInCollectionView(tableView)

        // execute the test
        tableView.queryDataSource()

        // assert
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(singleSectionDataSource === dataSource.dataSources[1])
        XCTAssertTrue(textReportsDataSource2 === dataSource.dataSources[0])
        XCTAssertEqual(1, tableView.numberOfSections)
        XCTAssertEqual(pdfReportsDataSource.items.count + textReportsDataSource.items.count, tableView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(total, tableView.ds_numberOfItems(inSection: 0))
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
    }

    func testMultipleDataSourcesSingleAndMultiCollectionView() {

        let collectionView = MockCollectionView()
        collectionView.numberOfReuseCells = 10

        let total = 55

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "pdf report")

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: total / 2, name: "text report")

        let singleSectionDataSource  = CompositeDataSource(sectionType: .multi)
        singleSectionDataSource.add(pdfReportsDataSource)
        singleSectionDataSource.add(textReportsDataSource)

        let textReportsDataSource2 = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource2.items = Report.generate(numberOfReports: total, name: "another report")

        let dataSource  = SegmentedDataSource()
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
        XCTAssertEqual(pdfReportsDataSource.items.count, collectionView.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(textReportsDataSource.items.count, collectionView.ds_numberOfItems(inSection: 1))
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
            XCTAssertTrue(cell.reports.contains(Report(id: index + 1, name: "text report-\(index + 1)")), "Invalid report at index: \(index)")
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
        
        let dataSource  = SegmentedDataSource()
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
        let view = dataSource.collectionView(collectionView, viewForSupplementaryElementOfKind: headerKind, at: indexPath)
        XCTAssertEqual(creator.view as? UIView, view)
        XCTAssertEqual(indexPath, creator.indexPath)
        XCTAssertEqual(headerKind, creator.kind)
        
        // size
        let size = dataSource.collectionView(collectionView, layout: UICollectionViewFlowLayout(), referenceSizeForFooterInSection: indexPath.section)
        XCTAssertEqual(creator.size, size)
        XCTAssertEqual(indexPath.section, creator.indexPath?.section)
        
        // will display
        dataSource.collectionView(collectionView, willDisplaySupplementaryView: UICollectionReusableView(), forElementKind: footerKind, at: indexPath)
        XCTAssertTrue(creator.willDisplayCalled)
        
        // did display
        dataSource.collectionView(collectionView, didEndDisplayingSupplementaryView: UICollectionReusableView(), forElementOfKind: headerKind, at: indexPath)
        XCTAssertTrue(creator.didDisplayCalled)
    }
    
    func testSupplementaryOutsideRange() {
        let dataSource = SegmentedDataSource()
        dataSource.add(CompositeDataSource(sectionType: .multi))
        
        let size = dataSource.collectionView(MockCollectionView(), layout: UICollectionViewFlowLayout(), referenceSizeForHeaderInSection: 2)
        XCTAssertEqual(CGSize.zero, size)
    }
}
