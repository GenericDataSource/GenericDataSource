//
//  _Utilities.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 10/23/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    func cast<T, U>(_ value: T) -> U {
        return cast(value, message: "Couldn't cast object '\(value)' to '\(U.self)'")
    }

    func cast<T, U>(_ value: T, message: String) -> U {
        guard let castedValue = value as? U else {
            fatalError("[\(type(of: self))]: \(message)")
        }
        return castedValue
    }

    func optionalCast<T, U>(_ value: T?) -> U? {
        return optionalCast(value, message: "Couldn't cast object '\(value)' to '\(U.self)'")
    }

    func optionalCast<T, U>(_ value: T?, message: String) -> U? {
        guard let unwrappedValue = value else {
            return nil
        }
        guard let castedValue = unwrappedValue as? U else {
            fatalError("[\(type(of: self))]: \(message)")
        }
        return castedValue
    }
}
