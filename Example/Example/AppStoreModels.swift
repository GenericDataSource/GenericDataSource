//
//  AppStoreModels.swift
//  Example
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 4/3/17.
//  Copyright © 2017 Mohamed Afifi. All rights reserved.
//

import Foundation

struct FeaturedApp {
    let name: String
    let category: String
    let price: Float
    let imageName: String
}

struct FeaturedSection {
    let title: String
    let featuredApps: [FeaturedApp]
}

struct FeaturedQuickLink {
    let name: String
    let url: URL
}

struct FeaturedPage {
    let sections: [FeaturedSection]

    let quickLinkLabel: String
    let quickLinks: [FeaturedQuickLink]
}
