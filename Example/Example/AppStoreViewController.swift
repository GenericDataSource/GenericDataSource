//
//  AppStoreViewController.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import UIKit
import GenericDataSource

class AppStoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!

    let dataSource = AppStoreDataSource()

    let service = Service()

    override func viewDidLoad() {
        super.viewDidLoad()

tableView.ds_register(cellNib: AppStoreFeaturedSectionTableViewCell.self)
tableView.ds_register(cellNib: AppStoreQuickLinkLabelTableViewCell.self)
tableView.ds_register(cellNib: AppStoreQuickLinkTableViewCell.self)
tableView.ds_register(cellNib: AppStoreFooterTableViewCell.self)
tableView.ds_register(cellNib: AppStoreLoadingTableViewCell.self)
tableView.ds_useDataSource(dataSource)

        loadData()
    }

    @IBAction func onRefreshTapped(_ sender: Any) {
        loadData()
    }

    private func loadData() {
// update the UI
refreshButton.isEnabled = false
dataSource.selectedDataSourceIndex = 0

// get the data from the service
service.getFeaturedPage { [weak self] page in

    // update the model
    self?.dataSource.page.page = page

    // update the UI
    self?.refreshButton.isEnabled = true
    self?.dataSource.selectedDataSourceIndex = 1
}
    }
}

// MAKR:- DataSources

class AppStoreDataSource: SegmentedDataSource {

    let loading = AppStoreLoadingDataSource()
    let page = AppStoreFeaturedPageDataSource()

    // reload data on index change
    override var selectedDataSourceIndex: Int {
        didSet {
            ds_reusableViewDelegate?.ds_reloadData()
        }
    }

    override init() {
        super.init()
        loading.items = [Void()] // we add 1 element to show the loading, 2 elements will show it twice. 0 will not show it.

        add(loading)
        add(page)
    }
}

class AppStoreFeaturedPageDataSource: CompositeDataSource {
    init() {
        super.init(sectionType: .single)
    }

    var page: FeaturedPage? {
        didSet {
            // remove all existing data sources
            removeAllDataSources()

            guard let page = page else {
                return
            }

            // add featured apps
            let featuredApps = AppStoreFeaturedAppsSectionDataSource()
            featuredApps.setSelectionHandler(UnselectableSelectionHandler())
            featuredApps.items = page.sections
            add(featuredApps)

            // add quick link label
            let quickLinkLabel = AppStoreQuickLinkLabelDataSource()
            quickLinkLabel.setSelectionHandler(UnselectableSelectionHandler())
            quickLinkLabel.items = [page.quickLinkLabel]
            add(quickLinkLabel)

            // add quick links
            let quickLinks = AppStoreQuickLinkDataSource()
            quickLinks.items = page.quickLinks
            add(quickLinks)

            // add footer
            let footer = AppStoreFooterDataSource()
            footer.setSelectionHandler(UnselectableSelectionHandler())
            footer.items = [Void()] // we add 1 element to show the footer, 2 elements will show it twice. 0 will not show it.
            add(footer)
        }
    }
}

class AppStoreFeaturedAppsDataSource: BasicDataSource<FeaturedApp, AppStoreFeaturedAppCollectionViewCell> {

    static var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: AppStoreFeaturedAppCollectionViewCell, with item: FeaturedApp, at indexPath: IndexPath) {
        cell.nameLabel.text = item.name
        cell.categoryLabel.text = item.category
        cell.priceLabel.text = type(of: self).formatter.string(from: NSNumber(value: item.price))
        cell.imageView.image = UIImage(named: item.imageName)
    }
}

class AppStoreFeaturedAppsSectionDataSource: BasicDataSource<FeaturedSection, AppStoreFeaturedSectionTableViewCell> {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: AppStoreFeaturedSectionTableViewCell, with item: FeaturedSection, at indexPath: IndexPath) {
        cell.title.text = item.title

        // set the featured apps
        cell.dataSource.items = item.featuredApps
        cell.collectionView.reloadData()
    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 252)
    }
}

class AppStoreQuickLinkLabelDataSource: BasicDataSource<String, AppStoreQuickLinkLabelTableViewCell> {
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: AppStoreQuickLinkLabelTableViewCell, with item: String, at indexPath: IndexPath) {
        cell.label.text = item
    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

class AppStoreQuickLinkDataSource: BasicDataSource<FeaturedQuickLink, AppStoreQuickLinkTableViewCell> {
    override func ds_collectionView(_ collectionView: GeneralCollectionView, configure cell: AppStoreQuickLinkTableViewCell, with item: FeaturedQuickLink, at indexPath: IndexPath) {
        cell.label.text = item.name
    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.item(at: indexPath)
        UIApplication.shared.openURL(item.url)
    }

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 45)
    }
}

class AppStoreFooterDataSource: BasicDataSource<Void, AppStoreFooterTableViewCell> {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.size.width, height: 140)
    }
}

class AppStoreLoadingDataSource: BasicDataSource<Void, AppStoreLoadingTableViewCell> {

    override func ds_collectionView(_ collectionView: GeneralCollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.size
    }
}
