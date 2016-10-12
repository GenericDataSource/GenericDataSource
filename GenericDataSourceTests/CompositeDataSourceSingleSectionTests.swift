//
//  CompositeDataSourceSingleSectionTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class CompositeDataSourceSingleSectionTests : XCTestCase {

    func testSizeForItemAtIndexPathMethod() {

        let dataSource  = CompositeDataSource(sectionType: .single)

        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])

        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)

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

    func testAddDataSource() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)

        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
    }
    
    func testInsertDataSource() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.insertDataSource(pdfReportsDataSource, atIndex: 0)
        
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.insertDataSource(textReportsDataSource, atIndex: 0)
        
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[1])
    }
    
    func testRemoveDataSource() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[1])
        
        dataSource.removeDataSource(pdfReportsDataSource)
        
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(textReportsDataSource === dataSource.dataSources[0])
        
        dataSource.removeDataSource(textReportsDataSource)
        XCTAssertEqual(0, dataSource.dataSources.count)
    }

    func testDataSourceAtIndex() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        XCTAssertEqual(1, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSources[0])
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(2, dataSource.dataSources.count)
        XCTAssertTrue(pdfReportsDataSource === dataSource.dataSourceAtIndex(0))
        XCTAssertTrue(textReportsDataSource === dataSource.dataSourceAtIndex(1))
    }
    
    func testContainsDataSource() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertTrue(dataSource.containsDataSource(pdfReportsDataSource))
        XCTAssertTrue(dataSource.containsDataSource(textReportsDataSource))
        XCTAssertFalse(dataSource.containsDataSource(ReportBasicDataSource<PDFReportCollectionViewCell>()))
    }
    
    func testIndexOfDataSource() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(0, dataSource.indexOfDataSource(pdfReportsDataSource))
        XCTAssertEqual(1, dataSource.indexOfDataSource(textReportsDataSource))
        XCTAssertNil(dataSource.indexOfDataSource(ReportBasicDataSource<PDFReportCollectionViewCell>()))
    }
    
    func testGlobalSectionForLocalSection() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(0, dataSource.globalSectionForLocalSection(0, dataSource: pdfReportsDataSource))
        XCTAssertEqual(5, dataSource.globalSectionForLocalSection(5, dataSource: pdfReportsDataSource))
        XCTAssertEqual(0, dataSource.globalSectionForLocalSection(0, dataSource: textReportsDataSource))
        XCTAssertEqual(5, dataSource.globalSectionForLocalSection(5, dataSource: textReportsDataSource))
    }
    
    func testLocalSectionForGlobalSection() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(0, dataSource.localSectionForGlobalSection(0, dataSource: pdfReportsDataSource))
        XCTAssertEqual(5, dataSource.localSectionForGlobalSection(5, dataSource: pdfReportsDataSource))
        XCTAssertEqual(0, dataSource.localSectionForGlobalSection(0, dataSource: textReportsDataSource))
        XCTAssertEqual(5, dataSource.localSectionForGlobalSection(5, dataSource: textReportsDataSource))
    }
    
    func testGlobalIndexPathForLocalIndexPath() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(IndexPath(item: 0, section: 0),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 0, section: 0), dataSource: pdfReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 5, section: 9), dataSource: pdfReportsDataSource))

        XCTAssertEqual(IndexPath(item: 50, section: 0),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 0, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 55, section: 9),
            dataSource.globalIndexPathForLocalIndexPath(IndexPath(item: 5, section: 9), dataSource: textReportsDataSource))
    }
    
    func testLocalIndexPathForGlobalIndexPath() {
        
        let dataSource  = CompositeDataSource(sectionType: .single)
        
        let pdfReportsDataSource = ReportBasicDataSource<PDFReportCollectionViewCell>()
        pdfReportsDataSource.items = Report.generate(numberOfReports: 50)
        dataSource.addDataSource(pdfReportsDataSource)
        
        let textReportsDataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        textReportsDataSource.items = Report.generate(numberOfReports: 200)
        dataSource.addDataSource(textReportsDataSource)
        
        XCTAssertEqual(IndexPath(item: 0, section: 0),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 0, section: 0), dataSource: pdfReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 5, section: 9), dataSource: pdfReportsDataSource))
        
        XCTAssertEqual(IndexPath(item: 0, section: 0),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 50, section: 0), dataSource: textReportsDataSource))
        XCTAssertEqual(IndexPath(item: 5, section: 9),
            dataSource.localIndexPathForGlobalIndexPath(IndexPath(item: 55, section: 9), dataSource: textReportsDataSource))
    }
}
