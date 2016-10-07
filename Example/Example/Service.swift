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
        return [Example(segue: "basic", title: "Basic"),
                Example(segue: "single", title: "Composite (SingleSection)"),
                Example(segue: "multiple", title: "Composite (MultipleSection)"),
                Example(segue: "mixed", title: "Composite (Single + Multiple)")]
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
}
