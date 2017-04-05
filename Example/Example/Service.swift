//
//  Service.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/b16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit

// bad design for a service, but it does the job for now.
class Service {

    class func getExamples() -> [Example] {
        return [
            Example(segue: "appstore", title: "App Store"),
            Example(segue: "basic", title: "Basic"),
            Example(segue: "single", title: "Composite (SingleSection)"),
            Example(segue: "multiple", title: "Composite (MultipleSection)"),
            Example(segue: "mixed", title: "Composite (Single + Multiple)")
        ]
    }

    class func getColors() -> [Color] {
        return [Color(color: UIColor.black, name: "Black"),
                Color(color: UIColor.darkGray, name: "Dark Gray"),
                Color(color: UIColor.lightGray, name: "Light Gray"),
                Color(color: UIColor.gray, name: "Gray"),
                Color(color: UIColor.red, name: "Red"),
                Color(color: UIColor.green, name: "Green"),
                Color(color: UIColor.blue, name: "Blue"),
                Color(color: UIColor.cyan, name: "Cyan"),
                Color(color: UIColor.yellow, name: "Yellow"),
                Color(color: UIColor.magenta, name: "Magenta"),
                Color(color: UIColor.orange, name: "Orange"),
                Color(color: UIColor.purple, name: "Purple"),
                Color(color: UIColor.brown, name: "Brown")]
    }

    class func getFewColors() -> [Color] {
        return [Color(color: UIColor.red, name: "Red"),
                Color(color: UIColor.green, name: "Green"),
                Color(color: UIColor.blue, name: "Blue"),
                Color(color: UIColor.cyan, name: "Cyan"),
                Color(color: UIColor.yellow, name: "Yellow"),
                Color(color: UIColor.magenta, name: "Magenta"),
                Color(color: UIColor.orange, name: "Orange"),
                Color(color: UIColor.purple, name: "Purple"),
                Color(color: UIColor.brown, name: "Brown")]
    }

    class func getContacts() -> [Contact] {
        return [Contact(name: "John Smith", email: "jonh@example.com"),
                Contact(name: "Ron Mac", email: "mac@example.com"),
                Contact(name: "Robert Jimmy", email: "jimmy@example.com"),
                Contact(name: "Mike Steven", email: "mike@example.com"),
                Contact(name: "Joe Ron", email: "ron@example.com")]
    }

    func getFeaturedPage(_ onCompletion: @escaping (FeaturedPage) -> Void) {
        // add 3 seconds loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            onCompletion(self.getFeaturedPage())
        }
    }

    private func getFeaturedPage() -> FeaturedPage {
        let apps = [
            FeaturedApp(name: "MARVEL Contest of Champions", category: "Games", price: 0.99, imageName: "app1"),
            FeaturedApp(name: "Force Saber of Light", category: "Games", price: 1.99, imageName: "app2"),
            FeaturedApp(name: "Batman: Arkham Origins", category: "Games", price: 2.99, imageName: "app3"),
            FeaturedApp(name: "Thomas & Friends: Go Go Thomas! – Speed Challenge", category: "Games", price: 3.99, imageName: "app4"),
            FeaturedApp(name: "Monster Truck Parking Game Real Car Racing Games", category: "Games", price: 4.99, imageName: "app5"),
            FeaturedApp(name: "Sonic & All-Stars Racing Transformed", category: "Games", price: 5.99, imageName: "app6"),
            FeaturedApp(name: "Dragons: Rise of Berk", category: "Games", price: 6.99, imageName: "app7"),
            FeaturedApp(name: "Real Steel World Robot Boxing", category: "Games", price: 7.99, imageName: "app8"),
            FeaturedApp(name: "Great Lightsaber", category: "Games", price: 8.99, imageName: "app9"),
            FeaturedApp(name: "Marvel's Iron Man 3 - JARVIS: A Second Screen Experience", category: "Games", price: 9.99, imageName: "app10")
        ]

        let sections = [
            FeaturedSection(title: "Comic-Inspired Games", featuredApps: apps),
            FeaturedSection(title: "More Fun with Games", featuredApps: apps.reversed())
        ]

        let quickLinks = [
            FeaturedQuickLink(name: "Add Payment Method", url: URL(string: "http://bfy.tw/B0ih")!),
            FeaturedQuickLink(name: "New to the App Store?", url: URL(string: "http://bfy.tw/B0ie")!),
            FeaturedQuickLink(name: "About In-App Purchases", url: URL(string: "http://bfy.tw/B0ik")!),
            FeaturedQuickLink(name: "Parents' Guide to iTunes", url: URL(string: "http://bfy.tw/B0iq")!),
            FeaturedQuickLink(name: "App Collections", url: URL(string: "http://bfy.tw/B0ir")!)
        ]

        return FeaturedPage(
            sections: sections,
            quickLinkLabel: "Quick Links",
            quickLinks: quickLinks)
    }
}
