# GenericDataSource

## 1.0.1

* Deprecating `useDelegateForItemSize` in favor of automatic detection if the user implemented `ds_collectionView(_:sizeForItemAtIndexPath:)` or not.
* Adding more code documentation and enhancing the readme file.

## 2.0.0

* Swift 3.0 Support.

## 2.1.0

* Renaming methods to match Swift 3.0 conventions.

## 2.2.0

* `UITableView` Header/Footer support.
* `UICollectionView` Supplmentary view support.

## 2.2.1

* Making Supplementary view optional as a workaround for the `UITableView` with .grouped style as it asks for the header/footer view even if the size is set as 0

## 2.3.0

* Adding `SegmentedDataSource`.

## 2.3.1

* Fixed a critical crash for `ds_collectionView(_:didEndDisplaying:forItemAt:)` in `CompositeDataSource`.
