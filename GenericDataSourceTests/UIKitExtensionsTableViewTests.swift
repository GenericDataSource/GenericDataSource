//
//  UIKitExtensionsTableViewTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class UIKitExtensionsTableViewTests: XCTestCase {
    
    var instance: UITableView!
    var dataSource: ReportBasicDataSource<TextReportTableViewCell>!
    
    override func setUp() {
        super.setUp()
        instance = UITableView()
        dataSource = ReportBasicDataSource<TextReportTableViewCell>()
        dataSource.items = Report.generate(numberOfReports: 10)
        instance.ds_useDataSource(dataSource)
        dataSource.registerReusableViewsInCollectionView(instance)
    }
    
    func testScrollPosition() {
        
        XCTAssertEqual(UITableViewScrollPosition.top, UITableViewScrollPosition(rawValue: .top))
        XCTAssertEqual(UITableViewScrollPosition.bottom, UITableViewScrollPosition(rawValue: .bottom))
        XCTAssertEqual(UITableViewScrollPosition.middle, UITableViewScrollPosition(rawValue: .centeredVertically))
        XCTAssertEqual(UITableViewScrollPosition.none, UITableViewScrollPosition(rawValue: .left))
        XCTAssertEqual(UITableViewScrollPosition.none, UITableViewScrollPosition(rawValue: .right))
        XCTAssertEqual(UITableViewScrollPosition.none, UITableViewScrollPosition(rawValue: .centeredHorizontally))
    }
    
    func testUsesDataSource() {
        
        instance.ds_useDataSource(dataSource)

        XCTAssertIdentical(instance.dataSource, dataSource)
        XCTAssertIdentical(instance.delegate, dataSource)
        XCTAssertTrue(instance === dataSource.ds_reusableViewDelegate)
    }
    
    func testRegisterNib() {
        instance.ds_registerNib(UINib(nibName: "TestTableViewCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "cell")
        
        let cell = instance.ds_dequeueReusableCellViewWithIdentifier("cell", forIndexPath: IndexPath(item: 0, section: 0))
        XCTAssertTrue(type(of: cell) == UITableViewCell.self)
    }
    
    func testRegisterClass() {
        instance.ds_registerClass(UITableViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let cell = instance.ds_dequeueReusableCellViewWithIdentifier("cell", forIndexPath: IndexPath(item: 0, section: 0))
        XCTAssertTrue(type(of: cell) == UITableViewCell.self)
    }
    
    func testReloadData() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        dataSource.items = Report.generate(numberOfReports: 100)
        instance.ds_reloadData()
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testInsertSections() {
        let sectionsDataSource = CompositeDataSource(type: .multiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        
        XCTAssertEqual(1, instance.ds_numberOfSections())
        
        sectionsDataSource.addDataSource(ReportBasicDataSource<TextReportTableViewCell>())
        
        instance.ds_insertSections(IndexSet(integer: 1), withRowAnimation: .none)
        XCTAssertEqual(2, instance.ds_numberOfSections())
    }
    
    func testDeleteSections() {
        let sectionsDataSource = CompositeDataSource(type: .multiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        
        XCTAssertEqual(1, instance.ds_numberOfSections())
        
        sectionsDataSource.removeDataSource(dataSource)
        
        instance.ds_deleteSections(IndexSet(integer: 0), withRowAnimation: .none)
        XCTAssertEqual(0, instance.ds_numberOfSections())
    }
    
    func testReloadSections() {
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        dataSource.items = Report.generate(numberOfReports: 100)
        
        instance.ds_reloadSections(IndexSet(integer: 0), withRowAnimation: .none)
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testMoveSection() {
        let sectionsDataSource = CompositeDataSource(type: .multiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        sectionsDataSource.addDataSource(ReportBasicDataSource<TextReportTableViewCell>())
        
        XCTAssertEqual(2, instance.ds_numberOfSections())
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(0).ds_numberOfItems(inSection: 0), instance.ds_numberOfItemsInSection(0))
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(1).ds_numberOfItems(inSection: 0), instance.ds_numberOfItemsInSection(1))
        
        sectionsDataSource.removeDataSource(dataSource)
        sectionsDataSource.addDataSource(dataSource)

        instance.ds_moveSection(0, toSection: 1)
        XCTAssertEqual(2, instance.ds_numberOfSections())
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(0).ds_numberOfItems(inSection: 0), instance.ds_numberOfItemsInSection(0))
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(1).ds_numberOfItems(inSection: 0), instance.ds_numberOfItemsInSection(1))
    }
    
    func testInsertItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        let start = dataSource.items.count
        dataSource.items.append(contentsOf: Report.generate(numberOfReports: 2))
        instance.ds_insertItemsAtIndexPaths([IndexPath(item: start + 1, section: 0), IndexPath(item: start, section: 0)], withRowAnimation: .none)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testDeleteItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        let start = dataSource.items.count
        dataSource.items.removeLast()
        dataSource.items.removeFirst()
        instance.ds_deleteItemsAtIndexPaths([IndexPath(item: start - 1, section: 0), IndexPath(item: 0, section: 0)], withRowAnimation: .none)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }

    func testReloadItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        instance.ds_reloadItemsAtIndexPaths([IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)], withRowAnimation: .none)
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testMoveItem() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        instance.ds_moveItemAtIndexPath(IndexPath(item: 0, section: 0), toIndexPath: IndexPath(item: 1, section: 0))
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testScrollToItem() {
        let index = IndexPath(item: 5, section: 0)
        instance.ds_scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.top, animated: false)
        XCTAssertEqual(CGPoint(x: 0, y: 44 * CGFloat((index as NSIndexPath).item)), instance.contentOffset)
    }
    
    func testSelection() {
        
        let index = IndexPath(item: 0, section: 0)
        instance.ds_selectItemAtIndexPath(index, animated: false, scrollPosition: .top)
        
        XCTAssertEqual([index], instance.ds_indexPathsForSelectedItems())
        
        instance.ds_deselectItemAtIndexPath(index, animated: false)
        XCTAssertEqual([], instance.ds_indexPathsForSelectedItems())
    }
    
    func testScrollView() {
        XCTAssertEqual(instance, instance.ds_scrollView)
    }
    
    func testLocalIndexPath() {
        let index = IndexPath(item: 19, section: 45)
        XCTAssertEqual(index, instance.ds_localIndexPathForGlobalIndexPath(index))
    }
    
    func testGlobalIndexPath() {
        let index = IndexPath(item: 19, section: 45)
        XCTAssertEqual(index, instance.ds_globalIndexPathForLocalIndexPath(index))
    }
    
    func testGlobalSection() {
        XCTAssertEqual(10, instance.ds_globalSectionForLocalSection(10))
    }
    
    func testIndexPathForCell() {
        let index = IndexPath(item: 0, section: 0)
        instance.ds_reloadData()
        let theCell = instance.ds_cellForItemAtIndexPath(index)
        XCTAssertNotNil(theCell)
        guard let cell = theCell else {
            XCTFail()
            return
        }
        XCTAssertTrue(type(of: cell) == TextReportTableViewCell.self)
        XCTAssertEqual(index, instance.ds_indexPathForCell(cell))
        XCTAssertNil(instance.ds_indexPathForCell(UITableViewCell()))
    }
    
    func testIndexPathForItemAtPoint() {
        let index = IndexPath(item: 0, section: 0)
        instance.ds_reloadData()
        XCTAssertEqual(index, instance.ds_indexPathForItemAtPoint(CGPoint.zero))
    }
    
    func testVisibleCells() {
        let index = IndexPath(item: 0, section: 0)
        instance.ds_reloadData()
        let theCell = instance.ds_cellForItemAtIndexPath(index)
        guard let cell = theCell as? UITableViewCell else {
            XCTFail()
            return
        }
        let cells = instance.ds_visibleCells()
        XCTAssertEqual(1, cells.count)
        XCTAssertEqual(cell, cells.first as? UITableViewCell)
    }
    
    func testVisibleIndexPaths() {
        XCTAssertEqual([], instance.ds_indexPathsForVisibleItems())
        
        let index = IndexPath(item: 0, section: 0)
        instance.ds_reloadData()
        XCTAssertEqual([index], instance.ds_indexPathsForVisibleItems())
    }
    
    func testPerformBatchUpdatesOneLevel() {
        let expectation = self.expectation(description: "performBatchUpdates")
        
        instance.ds_reloadData()
        
        instance.ds_performBatchUpdates({ () -> Void in
            
            self.dataSource.items.append(contentsOf: Report.generate(numberOfReports: 1))
            self.instance.ds_insertItemsAtIndexPaths([IndexPath(item: self.dataSource.items.count - 1, section: 0)], withRowAnimation: .none)
            
            }) { (completed) -> Void in
                
                expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testPerformBatchUpdates2Levels() {
        let expectation = self.expectation(description: "performBatchUpdates")
        
        instance.ds_reloadData()
        
        instance.ds_performBatchUpdates({ () -> Void in
            
            self.dataSource.items.append(contentsOf: Report.generate(numberOfReports: 1))
            self.instance.ds_insertItemsAtIndexPaths([IndexPath(item: self.dataSource.items.count - 1, section: 0)], withRowAnimation: .none)
            
            self.instance.ds_performBatchUpdates({ () -> Void in
                
                self.dataSource.items.append(contentsOf: Report.generate(numberOfReports: 1))
                self.instance.ds_insertItemsAtIndexPaths([IndexPath(item: self.dataSource.items.count - 1, section: 0)], withRowAnimation: .none)
                
                }, completion: { _ -> Void in
                    expectation.fulfill()
            })
            
            }) { _ -> Void in
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
}
