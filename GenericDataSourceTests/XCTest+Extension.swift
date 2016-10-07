//
//  XCTest+Extension.swift
//  GenericDataSource
//
//  Created by Mohamed Afifi on 2/28/16.
//  Copyright © 2016 mohamede1945. All rights reserved.
//

import XCTest


public func XCTAssertIdentical<T: AnyObject>(_ expression1: @autoclosure () -> T?, _ expression2: @autoclosure () -> T?, _ message: String = "", file: StaticString = #file, line: UInt = #line) {
    
    let object1 = expression1()
    let object2 = expression2()
    let errorMessage = !message.isEmpty ? message : "Object \(object1) is not identical to \(object2)"

    XCTAssertTrue(object1 === object2, errorMessage, file: file, line: line)
}


public func XCTAssertIdentical<T: AnyObject>(_ expression1: @autoclosure () -> [T]?, _ expression2: @autoclosure () -> [T]?, _ message: String = "", file: StaticString = #file, line: UInt = #line) {
    
    let object1 = expression1()
    let object2 = expression2()
    let errorMessage = !message.isEmpty ? message : "Object \(object1) is not identical to \(object2)"
    
    XCTAssertEqual(object1?.count, object2?.count, errorMessage, file: file, line: line)
    
    guard let castedObject1 = object1, let castedObject2 = object2 else {
        return
    }
    
    for i in 0..<castedObject1.count {
        XCTAssertTrue(castedObject1[i] === castedObject2[i], errorMessage, file: file, line: line)
    }
}
