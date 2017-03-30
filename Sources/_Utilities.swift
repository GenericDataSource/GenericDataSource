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
        return optionalCast(value, message: "Couldn't cast object '\(String(describing: value))' to '\(U.self)'")
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

func describe(_ object: AnyObject, properties: [(String, Any?)]) -> String {
    let address = String(format: "%p", unsafeBitCast(object, to: Int.self))
    let type: AnyObject.Type = type(of: object)
    let propertiesDescription = properties.filter { $1 != nil }.map { "\($0)=\($1!))" }.joined(separator: " ;")
    return "<\(type): \(address); \(propertiesDescription)>"
}

func isSelector(_ selector: Selector, belongsToProtocol aProtocol: Protocol) -> Bool {
    return isSelector(selector, belongsToProtocol: aProtocol, isRequired: true, isInstance: true) ||
        isSelector(selector, belongsToProtocol: aProtocol, isRequired: false, isInstance: true)
}

func isSelector(_ selector: Selector, belongsToProtocol aProtocol: Protocol, isRequired: Bool, isInstance: Bool) -> Bool {
    let method = protocol_getMethodDescription(aProtocol, selector, isRequired, isInstance)
    return method.types != nil
}
