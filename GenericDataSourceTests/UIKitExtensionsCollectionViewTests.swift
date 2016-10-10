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
        flowLayout.scrollDirection = .vertical
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
        instance.ds_register(UINib(nibName: "TestCollectionView", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "cell")
        
        let cell = instance.ds_dequeueReusableCell(withIdentifier: "cell", for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(type(of: cell) == UICollectionViewCell.self)
    }
    
    func testRegisterClass() {
        instance.ds_register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let cell = instance.ds_dequeueReusableCell(withIdentifier: "cell", for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(type(of: cell) == UICollectionViewCell.self)
    }
    
    func testReloadData() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
        
        dataSource.items = Report.generate(numberOfReports: 100)
        instance.ds_reloadData()
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testInsertSections() {
        let sectionsDataSource = CompositeDataSource(type: .multiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        
        XCTAssertEqual(1, instance.ds_numberOfSections())
        
        sectionsDataSource.addDataSource(ReportBasicDataSource<TextReportCollectionViewCell>())
        
        instance.ds_insertSections(IndexSet(integer: 1), with: .none)
        XCTAssertEqual(2, instance.ds_numberOfSections())
    }
    
    func testDeleteSections() {
        let sectionsDataSource = CompositeDataSource(type: .multiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        
        XCTAssertEqual(1, instance.ds_numberOfSections())
        
        sectionsDataSource.removeDataSource(dataSource)
        
        instance.ds_deleteSections(IndexSet(integer: 0), with: .none)
        XCTAssertEqual(0, instance.ds_numberOfSections())
    }
    
    func testReloadSections() {
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
        
        dataSource.items = Report.generate(numberOfReports: 100)
        
        instance.ds_reloadSections(IndexSet(integer: 0), with: .none)
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testMoveSection() {
        let sectionsDataSource = CompositeDataSource(type: .multiSection)
        sectionsDataSource.addDataSource(dataSource)
        instance.ds_useDataSource(sectionsDataSource)
        sectionsDataSource.addDataSource(ReportBasicDataSource<TextReportCollectionViewCell>())
        
        XCTAssertEqual(2, instance.ds_numberOfSections())
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(0).ds_numberOfItems(inSection: 0), instance.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(1).ds_numberOfItems(inSection: 0), instance.ds_numberOfItems(inSection: 1))
        
        sectionsDataSource.removeDataSource(dataSource)
        sectionsDataSource.addDataSource(dataSource)
        
        instance.ds_moveSection(0, toSection: 1)
        XCTAssertEqual(2, instance.ds_numberOfSections())
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(0).ds_numberOfItems(inSection: 0), instance.ds_numberOfItems(inSection: 0))
        XCTAssertEqual(sectionsDataSource.dataSourceAtIndex(1).ds_numberOfItems(inSection: 0), instance.ds_numberOfItems(inSection: 1))
    }
    
    func testInsertItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
        
        let start = dataSource.items.count
        dataSource.items.append(contentsOf: Report.generate(numberOfReports: 2))
        instance.ds_insertItems(at: [IndexPath(item: start + 1, section: 0), IndexPath(item: start, section: 0)], with: .none)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testDeleteItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
        
        let start = dataSource.items.count
        dataSource.items.removeLast()
        dataSource.items.removeFirst()
        instance.ds_deleteItems(at: [IndexPath(item: start - 1, section: 0), IndexPath(item: 0, section: 0)], with: .none)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testReloadItems() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
        
        instance.ds_reloadItems(at: [IndexPath(item: 1, section: 0), IndexPath(item: 0, section: 0)], with: .none)
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testMoveItem() {
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
        
        instance.ds_moveItem(at: IndexPath(item: 0, section: 0), to: IndexPath(item: 1, section: 0))
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testScrollToItem() {
        let index = IndexPath(item: 5, section: 0)
        instance.ds_scrollToItem(at: index, at: UICollectionViewScrollPosition.left, animated: false)
    }

    func testSelection() {
        let index = IndexPath(item: 0, section: 0)
        instance.ds_selectItem(at: index, animated: false, scrollPosition: .top)
        
        XCTAssertEqual([index], instance.ds_indexPathsForSelectedItems())
        
        instance.ds_deselectItem(at: index, animated: false)
        XCTAssertEqual([], instance.ds_indexPathsForSelectedItems())
    }

    func testIndexPathsForSelectedItemsNil() {
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
        instance.layoutIfNeeded()
        let theCell = instance.ds_cellForItem(at: index)
        XCTAssertNotNil(theCell)
        guard let cell = theCell else {
            XCTFail()
            return
        }
        XCTAssertTrue(type(of: cell) == TextReportCollectionViewCell.self)
        XCTAssertEqual(index, instance.ds_indexPath(for: cell))
        XCTAssertNil(instance.ds_indexPath(for: UICollectionViewCell()))
    }
    
    func testIndexPathForItemAtPoint() {
        let index = IndexPath(item: 0, section: 0)
        instance.ds_reloadData()
        XCTAssertEqual(index, instance.ds_indexPathForItem(at: CGPoint.zero))
    }
    
    func testVisibleCells() {
        var indexes = [IndexPath]()
        for item in 0..<10 {
            indexes.append(IndexPath(item: item, section: 0))
        }
        instance.ds_reloadData()
        instance.layoutIfNeeded()
        
        var expectedCells = [UICollectionViewCell]()
        for index in indexes {
            let theCell = instance.ds_cellForItem(at: index)
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
        let expectation = self.expectation(description: "performBatchUpdates")
        
        instance.ds_reloadData()
        
        instance.ds_performBatchUpdates({ () -> Void in
            
            self.dataSource.items.append(contentsOf: Report.generate(numberOfReports: 1))
            self.instance.ds_insertItems(at: [IndexPath(item: self.dataSource.items.count - 1, section: 0)], with: .none)
            
            }) { (completed) -> Void in
            
                expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
    
    func testPerformBatchUpdates2Levels() {
        let expectation = self.expectation(description: "performBatchUpdates")
        
        instance.ds_reloadData()
        
        instance.ds_performBatchUpdates({ () -> Void in
            
            self.dataSource.items.append(contentsOf: Report.generate(numberOfReports: 1))
            self.instance.ds_insertItems(at: [IndexPath(item: self.dataSource.items.count - 1, section: 0)], with: .none)
            
            self.instance.ds_performBatchUpdates({ () -> Void in
                
                self.dataSource.items.append(contentsOf: Report.generate(numberOfReports: 1))
                self.instance.ds_insertItems(at: [IndexPath(item: self.dataSource.items.count - 1, section: 0)], with: .none)
                
                }, completion: { _ -> Void in
                    expectation.fulfill()
            })
            
            }) { _ -> Void in
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(dataSource.items.count, instance.ds_numberOfItems(inSection: 0))
    }
}
