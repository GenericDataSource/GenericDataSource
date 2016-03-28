//
//  AbstractDataSource.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 9/16/15.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import UIKit

private let sizeSelectors: [Selector] = [
    #selector(UITableViewDelegate.tableView(_:heightForRowAtIndexPath:)),
    #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:sizeForItemAtIndexPath:))
]

public class AbstractDataSource : NSObject, DataSource, UITableViewDataSource, UICollectionViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout {

    // retained
    public var scrollViewDelegate: UIScrollViewDelegate? = nil {
        willSet {
            precondition(self !== newValue, "You cannot set a DataSource as UIScrollViewDelegate. Instead just override the UIScrollViewDelegate methods.")
        }
    }

    public weak var ds_reusableViewDelegate: GeneralCollectionView? = nil
    
    public override init() {
        let type = AbstractDataSource.self
        guard self.dynamicType != type else {
            fatalError("\(type) instances can not be created; create a subclass instance instead.")
        }
    }

    // MARK: respondsToSelector

    private func scrollViewDelegateCanHandleSelector(selector: Selector) -> Bool {
        if let scrollViewDelegate = scrollViewDelegate
            where isSelector(selector, belongsToProtocol: UIScrollViewDelegate.self) &&
                scrollViewDelegate.respondsToSelector(selector) {
            return true
        }
        return false
    }

    public override func respondsToSelector(selector: Selector) -> Bool {

        if sizeSelectors.contains(selector) {
            return ds_shouldConsumeItemSizeDelegateCalls()
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
        return ds_numberOfSections()
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ds_numberOfSections() <= section {
            return 0
        }
        return ds_numberOfItems(inSection: section)
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ds_collectionView(tableView, cellForItemAtIndexPath: indexPath)
        guard let castedCell = cell as? UITableViewCell else {
            fatalError("Couldn't cast cell '\(cell)' to UITableViewCell")
        }
        return castedCell
    }

    // MARK:- UICollectionViewDataSource

    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ds_numberOfItems(inSection: section)
    }

    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return ds_numberOfSections()
    }

    public func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell: ReusableCell = ds_collectionView(collectionView, cellForItemAtIndexPath: indexPath)
            guard let castedCell = cell as? UICollectionViewCell else {
                fatalError("Couldn't cast cell '\(cell)' to UICollectionViewCell")
            }
            return castedCell
    }

    // MARK:- UITableViewDelegate
    
    // MARK: Selection

    public func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ds_collectionView(tableView, shouldHighlightItemAtIndexPath: indexPath)
    }

    public func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(tableView, didHighlightItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(tableView, didUnhighlightRowAtIndexPath: indexPath)
    }

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(tableView, didSelectItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return ds_collectionView(tableView, shouldSelectItemAtIndexPath: indexPath) ? indexPath : nil
    }
    
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(tableView, didDeselectItemAtIndexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return ds_collectionView(tableView, shouldDeselectItemAtIndexPath: indexPath) ? indexPath : nil
    }
    
    // MARK: Size

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ds_collectionView(tableView, sizeForItemAtIndexPath: indexPath).height
    }

    // MARK:- UICollectionViewDelegate
    
    // MARK: Selection

    public func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ds_collectionView(collectionView, shouldHighlightItemAtIndexPath: indexPath)
    }

    public func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(collectionView, didHighlightItemAtIndexPath: indexPath)
    }

    public func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(collectionView, didUnhighlightRowAtIndexPath: indexPath)
    }

    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ds_collectionView(collectionView, shouldSelectItemAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        return ds_collectionView(collectionView, didDeselectItemAtIndexPath: indexPath)
    }
    
    public func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return ds_collectionView(collectionView, shouldDeselectItemAtIndexPath: indexPath)
    }

    // MARK: Size

    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return ds_collectionView(collectionView, sizeForItemAtIndexPath: indexPath)
    }

    // MARK:- Data Source

    public func ds_numberOfSections() -> Int {
        fatalError("\(self): \(#function) Should be implemented by subclasses")
    }
    
    public func ds_numberOfItems(inSection section: Int) -> Int {
        fatalError("\(self): \(#function) Should be implemented by subclasses")
    }

    public func ds_collectionView(collectionView: GeneralCollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ReusableCell {
        fatalError("\(self): \(#function) Should be implemented by subclasses")
    }
    
    public func ds_collectionView(collectionView: GeneralCollectionView, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        fatalError("\(self): \(#function) Should be implemented by subclasses")
    }

    public func ds_shouldConsumeItemSizeDelegateCalls() -> Bool {
        return false
    }
    
    public func ds_collectionView(collectionView: GeneralCollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    public func ds_collectionView(collectionView: GeneralCollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }
    
    public func ds_collectionView(collectionView: GeneralCollectionView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }

    public func ds_collectionView(collectionView: GeneralCollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    public func ds_collectionView(collectionView: GeneralCollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }

    public func ds_collectionView(collectionView: GeneralCollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    public func ds_collectionView(collectionView: GeneralCollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // does nothing
    }
}

private func isSelector(selector: Selector, belongsToProtocol aProtocol: Protocol) -> Bool {
    return isSelector(selector, belongsToProtocol: aProtocol, isRequired: true, isInstance: true) ||
        isSelector(selector, belongsToProtocol: aProtocol, isRequired: false, isInstance: true)
}

private func isSelector(selector: Selector, belongsToProtocol aProtocol: Protocol, isRequired: Bool, isInstance: Bool) -> Bool {
    let method = protocol_getMethodDescription(aProtocol, selector, isRequired, isInstance)
    return method.types != nil
}