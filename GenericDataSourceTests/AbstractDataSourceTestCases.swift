//
//  AbstractDataSourceTestCases.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/27/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

private class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
    
    private var called = false
    
    @objc func scrollViewDidScroll(scrollView: UIScrollView) {
        called = true
    }
    
    @objc func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        called = true
        return nil
    }
}

class AbstractDataSourceTestCases: XCTestCase {
    
    var instance: ReportBasicDataSource<PDFReportCollectionViewCell>!
    var tableView: UITableView!
    private var delegate: ScrollViewDelegate!
    
    override func setUp() {
        super.setUp()
        delegate = ScrollViewDelegate()
        instance = ReportBasicDataSource<PDFReportCollectionViewCell>()
        instance.scrollViewDelegate = delegate
        tableView = UITableView()
        tableView.ds_useDataSource(instance)
    }

    func testScrollViewDelegateNotSet() {
        instance.scrollViewDelegate = nil
        
        XCTAssertFalse(delegate.called)
        tableView.delegate?.scrollViewDidScroll?(tableView)
        XCTAssertFalse(delegate.called)
    }
    
    func testScrollViewDelegateSetDidScroll() {
        
        XCTAssertFalse(delegate.called)
        tableView.delegate?.scrollViewDidScroll?(tableView)
        XCTAssertTrue(delegate.called)
    }
    
    func testScrollViewDelegateSetViewForZooming() {
        
        XCTAssertFalse(delegate.called)
        tableView.delegate?.viewForZoomingInScrollView?(tableView)
        XCTAssertTrue(delegate.called)
    }
}
