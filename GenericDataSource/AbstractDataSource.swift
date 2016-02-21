//
//  AbstractDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

internal let sizeSelectors: [Selector] = ["tableView:heightForRowAtIndexPath:", "collectionView:layout:sizeForItemAtIndexPath:"]

public class AbstractDataSource : NSObject, DataSource, UITableViewDataSource, UICollectionViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {

    public var scrollViewDelegate: UIScrollViewDelegate? = nil

    public weak var reusableViewDelegate: DataSourceReusableViewDelegate? = nil
    
    public override init() {
        let type = AbstractDataSource.self
        guard self.dynamicType != type else {
            fatalError("\(type) instances can not be created; create a subclass instance instead.")
        }
    }

    // MARK: respondsToSelector

    private func scrollViewDelegateCanHandleSelector(selector: Selector) -> Bool {
        if let scrollViewDelegate = scrollViewDelegate where selector.description.hasPrefix("scrollView") && scrollViewDelegate.respondsToSelector(selector) {
            return true
        }
        return false
    }

    public override func respondsToSelector(selector: Selector) -> Bool {

        if sizeSelectors.contains(selector) {
            return canHandleCellSize()
        }

        if scrollViewDelegateCanHandleSelector(selector) {
             return true
        }

        return super.respondsToSelector(selector)
    }
    
    public override func forwardingTargetForSelector(selector: Selector) -> AnyObject? {
        if scrollViewDelegateCanHandleSelector(selector) {
            return scrollViewDelegate
        }
        return super.forwardingTargetForSelector(selector)
    }

    // MARK:- DataSource

    // MARK: UITableViewDataSource

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections()
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableCollectionView(tableView, cellForItemAtIndexPath: indexPath) as! UITableViewCell
    }

    // MARK:- UICollectionViewDataSource

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(inSection: section)
    }

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }

    public func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            return tableCollectionView(collectionView, cellForItemAtIndexPath: indexPath) as! UICollectionViewCell
    }

    // MARK:- UITableViewDelegate
    
    // MARK: Selection

    public func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return tableCollectionView(tableView, shouldHighlightItemAtIndexPath: indexPath)
    }

    public func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(tableView, didHighlightItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(tableView, didUnhighlightRowAtIndexPath: indexPath)
    }

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(tableView, didSelectItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return tableCollectionView(tableView, willSelectItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(tableView, didDeselectItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return tableCollectionView(tableView, willDeselectItemAtIndexPath: indexPath)
    }
    
    // MARK: Size

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableCollectionView(tableView, sizeForItemAtIndexPath: indexPath).height
    }

    // MARK:- UICollectionViewDelegate
    
    // MARK: Selection

    public func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return tableCollectionView(collectionView, shouldHighlightItemAtIndexPath: indexPath)
    }

    public func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(collectionView, didHighlightItemAtIndexPath: indexPath)
    }

    public func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(collectionView, didUnhighlightRowAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return tableCollectionView(collectionView, willSelectItemAtIndexPath: indexPath) != nil
    }
    
    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        return tableCollectionView(collectionView, didDeselectItemAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return tableCollectionView(collectionView, willDeselectItemAtIndexPath: indexPath) != nil
    }

    // MARK: Size

    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return tableCollectionView(collectionView, sizeForItemAtIndexPath: indexPath)
    }

    // MARK:- Data Source
    
    public func numberOfSections() -> Int {
        fatalError("\(self): Should be implemented by subclasses")
    }
    
    public func numberOfItems(inSection section: Int) -> Int {
        fatalError("\(self): Should be implemented by subclasses")
    }

    public func tableCollectionView(tableCollectionView: TableCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {
        fatalError("\(self): Should be implemented by subclasses")
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        fatalError("\(self): \(__FUNCTION__) Should be implemented by subclasses")
    }

    public func canHandleCellSize() -> Bool {
        return false
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, willSelectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }
    
    public func tableCollectionView(tableCollectionView: TableCollectionView, willDeselectItemAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return indexPath
    }
    public func tableCollectionView(tableCollectionView: TableCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }
}