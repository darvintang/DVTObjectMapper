//
//  IntegerOperators.swift
//  DVTObjectMapper
//
//  Created by darvin on 2021/9/19.
//

/*

 MIT License

 Copyright (c) 2023 darvin http://blog.tcoding.cn

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 */

import Foundation

// MARK: - Signed Integer

/// SignedInteger mapping
public func <<< <T: SignedInteger>(left: inout T, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        let value: T? = T.toInteger(right.currentValue)
        FromJSON.basicType(&left, object: value ?? 0)
    }
}

/// SignedInteger mapping
public func <- <T: SignedInteger>(left: inout T, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional SignedInteger mapping
public func <<< <T: SignedInteger>(left: inout T?, right: Map) {
    switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            let value: T? = T.toInteger(right.currentValue)
            FromJSON.basicType(&left, object: value)
        case .toJSON:
            left >>> right
        default: ()
    }
}

/// Optional SignedInteger mapping
public func <- <T: SignedInteger>(left: inout T?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Unsigned Integer

/// UnsignedInteger mapping
public func <<< <T: UnsignedInteger>(left: inout T, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        let value: T? = T.toInteger(right.currentValue)
        FromJSON.basicType(&left, object: value ?? 0)
    }
}

/// Optional UnsignedInteger mapping
public func <<< <T: UnsignedInteger>(left: inout T?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        let value: T? = T.toInteger(right.currentValue)
        FromJSON.basicType(&left, object: value)
    }
}

/// UnsignedInteger mapping
public func <- <T: UnsignedInteger>(left: inout T, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional UnsignedInteger mapping
public func <- <T: UnsignedInteger>(left: inout T?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Casting Utils

/// Convert any value to `SignedInteger`.
private func toSignedInteger<T: SignedInteger>(_ value: Any?) -> T? {
    guard
        case let number as NSNumber = value
    else {
        if case let stringValue as String = value, let tempInt64 = Int64(stringValue) {
            return T(exactly: tempInt64)
        }
        return nil
    }
    return T(exactly: number.int64Value)
}

public extension BinaryInteger {
    static func toInteger(_ value: Any?) -> Self? {
        var resNumber: NSNumber = 0
        if case let number as NSNumber = value {
            resNumber = number
        } else if case let stringValue as String = value, let tempValue = Double(stringValue) {
            resNumber = NSNumber(value: tempValue)
        } else {
            return nil
        }
        if self.isSigned {
            return Self(exactly: resNumber.int64Value)
        } else {
            return Self(exactly: resNumber.uint64Value)
        }
    }
}
