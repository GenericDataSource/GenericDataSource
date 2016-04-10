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
        return [Color(color: UIColor.blackColor(), name: "Black"),
                Color(color: UIColor.darkGrayColor(), name: "Dark Gray"),
                Color(color: UIColor.lightGrayColor(), name: "Light Gray"),
                Color(color: UIColor.grayColor(), name: "Gray"),
                Color(color: UIColor.redColor(), name: "Red"),
                Color(color: UIColor.greenColor(), name: "Green"),
                Color(color: UIColor.blueColor(), name: "Blue"),
                Color(color: UIColor.cyanColor(), name: "Cyan"),
                Color(color: UIColor.yellowColor(), name: "Yellow"),
                Color(color: UIColor.magentaColor(), name: "Magenta"),
                Color(color: UIColor.orangeColor(), name: "Orange"),
                Color(color: UIColor.purpleColor(), name: "Purple"),
                Color(color: UIColor.brownColor(), name: "Brown")]
    }

    class func getFewColors() -> [Color] {
        return [Color(color: UIColor.redColor(), name: "Red"),
                Color(color: UIColor.greenColor(), name: "Green"),
                Color(color: UIColor.blueColor(), name: "Blue"),
                Color(color: UIColor.cyanColor(), name: "Cyan"),
                Color(color: UIColor.yellowColor(), name: "Yellow"),
                Color(color: UIColor.magentaColor(), name: "Magenta"),
                Color(color: UIColor.orangeColor(), name: "Orange"),
                Color(color: UIColor.purpleColor(), name: "Purple"),
                Color(color: UIColor.brownColor(), name: "Brown")]
    }

    class func getContacts() -> [Contact] {
        return [Contact(name: "John Smith", email: "jonh@example.com"),
                Contact(name: "Ron Mac", email: "mac@example.com"),
                Contact(name: "Robert Jimmy", email: "jimmy@example.com"),
                Contact(name: "Mike Steven", email: "mike@example.com"),
                Contact(name: "Joe Ron", email: "ron@example.com")]
    }
}