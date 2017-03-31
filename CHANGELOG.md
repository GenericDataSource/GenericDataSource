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

## 2.4.0

* `ds_shouldConsumeItemSizeDelegateCalls` is unavailable, instead use `ds_responds(to selector: DataSourceSelector) -> Bool`, It takes an enum, with `.size` it act the same as `ds_shouldConsumeItemSizeDelegateCalls`.
* Fixes a bug that makes all table view cells editable by default.
* New `ds_responds(to selector: DataSourceSelector) -> Bool` to make it so easy to make some implementations of `DataSource` methods optional (e.g. we used it to fix the editable table view cells bug). 

## 2.4.1

* `@autoclosure` of casting fatal message. Improves performance since there is string manipulation.
