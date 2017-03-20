//
//  AnyBasicDataSourceRepresentableTests.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/20/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class AnyBasicDataSourceRepresentableTests: XCTestCase {

    func testItems() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let instance = dataSource.asBasicDataSourceRepresentable()
        let reports = Report.generate(numberOfReports: 20)
        instance.items = reports

        XCTAssertEqual(instance.items, reports)
    }

    func testDataSource() {
        let dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        let instance = dataSource.asBasicDataSourceRepresentable()
        XCTAssertIdentical(dataSource, instance.dataSource)
    }
}
