//
//  Model.swift
//  Example
//
//  Created by Mohamed Afifi on 4/3/16.
//  Copyright © 2016 Mohamed Afifi. All rights reserved.
//

import UIKit

struct Example {
    let segue: String
    let title: String
}

struct Contact: NameableEntity {
    let name: String
    let email: String
}

struct Color: NameableEntity {
    let color: UIColor
    let name: String
}

