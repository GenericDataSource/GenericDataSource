//
//  UIKitExtensionsCollectionViewTests.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 3/13/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest
@testable import GenericDataSource

class UIKitExtensionsCollectionViewTests: XCTestCase {
    
    var instance: UICollectionView!
    var dataSource: ReportBasicDataSource<TextReportCollectionViewCell>!
    
    override func setUp() {
        super.setUp()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: 10, height: 10)
        instance = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: flowLayout)
        dataSource = ReportBasicDataSource<TextReportCollectionViewCell>()
        dataSource.items = Report.generate(numberOfReports: 10)
        instance.ds_useDataSource(dataSource)
        dataSource.registerReusableViewsInCollectionView(instance)
    }
    
    func testUsesDataSource() {
        
        instance.ds_useDataSource(dataSource)
        
        XCTAssertIdentical(instance.dataSource, dataSource)
        XCTAssertIdentical(instance.delegate, dataSource)
        XCTAssertTrue(instance === dataSource.ds_reusableViewDelegate)
    }
    
    func testRegisterNib() {
        instance.ds_registerNib(UINib(nibName: "TestCollectionView", bundle: NSBundle(forClass: self.dynamicType)), forCellWithReuseIdentifier: "cell")
        
        let cell = instance.ds_dequeueReusableCellViewWithIdentifier("cell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertTrue(cell.dynamicType == UICollectionViewCell.self)
    }
    
    func testRegisterClass() {
        instance.ds_registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let cell = instance.ds_dequeueReusableCellViewWithIdentifier("cell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        XCTAssertTrue(cell.dynamicType == UICollectionViewCell.self)
    }
    
    func testReloadData() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        dataSource.items = Report.generate(numberOfReports: 100)
        instance.ds_reloadData()
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testInsertSections() {
        let sectionsDataSource = CompositeDataSource(type: .MultiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        
        XCTAssertEqual(1, instance.ds_numberOfSections())
        
        sectionsDataSource.addDataSource(ReportBasicDataSource<TextReportCollectionViewCell>())
        
        instance.ds_insertSections(NSIndexSet(index: 1), withRowAnimation: .None)
        XCTAssertEqual(2, instance.ds_numberOfSections())
    }
    
    func testDeleteSections() {
        let sectionsDataSource = CompositeDataSource(type: .MultiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        
        XCTAssertEqual(1, instance.ds_numberOfSections())
        
        sectionsDataSource.removeDataSource(dataSource)
        
        instance.ds_deleteSections(NSIndexSet(index: 0), withRowAnimation: .None)
        XCTAssertEqual(0, instance.ds_numberOfSections())
    }
    
    func testReloadSections() {
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        dataSource.items = Report.generate(numberOfReports: 100)
        
        instance.ds_reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testMoveSection() {
        let sectionsDataSource = CompositeDataSource(type: .MultiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        sectionsDataSource.addDataSource(ReportBasicDataSource<TextReportCollectionViewCell>())
        
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
        dataSource.items.appendContentsOf(Report.generate(numberOfReports: 2))
        instance.ds_insertItemsAtIndexPaths([NSIndexPath(forItem: start + 1, inSection: 0), NSIndexPath(forItem: start, inSection: 0)], withRowAnimation: .None)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testDeleteItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        let start = dataSource.items.count
        dataSource.items.removeLast()
        dataSource.items.removeFirst()
        instance.ds_deleteItemsAtIndexPaths([NSIndexPath(forItem: start - 1, inSection: 0), NSIndexPath(forItem: 0, inSection: 0)], withRowAnimation: .None)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testReloadItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        instance.ds_reloadItemsAtIndexPaths([NSIndexPath(forItem: 1, inSection: 0), NSIndexPath(forItem: 0, inSection: 0)], withRowAnimation: .None)
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testMoveItem() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
        
        instance.ds_moveItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), toIndexPath: NSIndexPath(forItem: 1, inSection: 0))
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testScrollToItem() {
        let index = NSIndexPath(forItem: 5, inSection: 0)
        instance.ds_scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
    }

    func testSelection() {
        let index = NSIndexPath(forItem: 0, inSection: 0)
        instance.ds_selectItemAtIndexPath(index, animated: false, scrollPosition: .Top)
        
        XCTAssertEqual([index], instance.ds_indexPathsForSelectedItems())
        
        instance.ds_deselectItemAtIndexPath(index, animated: false)
        XCTAssertEqual([], instance.ds_indexPathsForSelectedItems())
    }

    func testIndexPathsForSelectedItemsNil() {
        XCTAssertEqual([], instance.ds_indexPathsForSelectedItems())
    }
    
    func testScrollView() {
        XCTAssertEqual(instance, instance.ds_scrollView)
    }
    
    func testLocalIndexPath() {
        let index = NSIndexPath(forItem: 19, inSection: 45)
        XCTAssertEqual(index, instance.ds_localIndexPathForGlobalIndexPath(index))
    }
    
    func testGlobalIndexPath() {
        let index = NSIndexPath(forItem: 19, inSection: 45)
        XCTAssertEqual(index, instance.ds_globalIndexPathForLocalIndexPath(index))
    }
    
    func testGlobalSection() {
        XCTAssertEqual(10, instance.ds_globalSectionForLocalSection(10))
    }
    
    func testIndexPathForCell() {
        let index = NSIndexPath(forItem: 0, inSection: 0)
        instance.ds_reloadData()
        instance.layoutIfNeeded()
        let theCell = instance.ds_cellForItemAtIndexPath(index)
        XCTAssertNotNil(theCell)
        guard let cell = theCell else {
            XCTFail()
            return
        }
        XCTAssertTrue(cell.dynamicType == TextReportCollectionViewCell.self)
        XCTAssertEqual(index, instance.ds_indexPathForCell(cell))
        XCTAssertNil(instance.ds_indexPathForCell(UICollectionViewCell()))
    }
    
    func testIndexPathForItemAtPoint() {
        let index = NSIndexPath(forItem: 0, inSection: 0)
        instance.ds_reloadData()
        XCTAssertEqual(index, instance.ds_indexPathForItemAtPoint(CGPoint.zero))
    }
    
    func testVisibleCells() {
        var indexes = [NSIndexPath]()
        for item in 0..<10 {
            indexes.append(NSIndexPath(forItem: item, inSection: 0))
        }
        instance.ds_reloadData()
        instance.layoutIfNeeded()
        
        var expectedCells = [UICollectionViewCell]()
        for index in indexes {
            let theCell = instance.ds_cellForItemAtIndexPath(index)
            guard let cell = theCell as? UICollectionViewCell else {
                XCTFail()
                return
            }
            expectedCells.append(cell)
        }
        let cells = instance.ds_visibleCells()
        XCTAssertEqual(expectedCells.count, cells.count)
    }
    
    func testVisibleIndexPaths() {
        XCTAssertEqual([], instance.ds_indexPathsForVisibleItems())
        
        instance.ds_reloadData()
        instance.layoutIfNeeded()
        XCTAssertEqual(10, instance.ds_indexPathsForVisibleItems().count)
    }
    
    func testPerformBatchUpdatesOneLevel() {
        let expectation = expectationWithDescription("performBatchUpdates")
        
        instance.ds_reloadData()
        
        instance.ds_performBatchUpdates({ () -> Void in
            
            self.dataSource.items.appendContentsOf(Report.generate(numberOfReports: 1))
            self.instance.ds_insertItemsAtIndexPaths([NSIndexPath(forItem: self.dataSource.items.count - 1, inSection: 0)], withRowAnimation: .None)
            
            }) { (completed) -> Void in
            
                expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10, handler: nil)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
    
    func testPerformBatchUpdates2Levels() {
        let expectation = expectationWithDescription("performBatchUpdates")
        
        instance.ds_reloadData()
        
        instance.ds_performBatchUpdates({ () -> Void in
            
            self.dataSource.items.appendContentsOf(Report.generate(numberOfReports: 1))
            self.instance.ds_insertItemsAtIndexPaths([NSIndexPath(forItem: self.dataSource.items.count - 1, inSection: 0)], withRowAnimation: .None)
            
            self.instance.ds_performBatchUpdates({ () -> Void in
                
                self.dataSource.items.appendContentsOf(Report.generate(numberOfReports: 1))
                self.instance.ds_insertItemsAtIndexPaths([NSIndexPath(forItem: self.dataSource.items.count - 1, inSection: 0)], withRowAnimation: .None)
                
                }, completion: { _ -> Void in
                    expectation.fulfill()
            })
            
            }) { _ -> Void in
        }
        
        waitForExpectationsWithTimeout(10, handler: nil)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItemsInSection(0))
    }
}
