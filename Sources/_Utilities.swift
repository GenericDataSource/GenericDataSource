//
//  _Utilities.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension NSObject {
    func cast<T, U>(_ value: T) -> U {
        guard let castedValue = value as? U else {
            fatalError("[\(type(of: self))]: Couldn't cast object '\(value)' to '\(U.self)'")
        }
        return castedValue
    }

    func cast<T, U>(_ value: T, message: String) -> U {
        guard let castedValue = value as? U else {
            fatalError("[\(type(of: self))]: \(message)")
        }
        return castedValue
    }
}
