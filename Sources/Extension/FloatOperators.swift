//
//  FloatOperators.swift
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

// MARK: - BinaryFloatingPoint

/// BinaryFloatingPoint mapping
public func <<< <T: BinaryFloatingPoint>(left: inout T, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        let value: T? = T.toFloatPoint(right.currentValue)
        FromJSON.basicType(&left, object: value ?? 0)
    }
}

/// Optional BinaryFloatingPoint mapping
public func <<< <T: BinaryFloatingPoint>(left: inout T?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        let value: T? = T.toFloatPoint(right.currentValue)
        FromJSON.basicType(&left, object: value)
    }
}

/// BinaryFloatingPoint mapping
public func <- <T: BinaryFloatingPoint>(left: inout T, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional BinaryFloatingPoint mapping
public func <- <T: BinaryFloatingPoint>(left: inout T?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Casting Utils

/// Convert any value to `BinaryFloatingPoint`.
public extension BinaryFloatingPoint {
    static func toFloatPoint(_ value: Any?) -> Self? {
        guard
            case let number as NSNumber = value
        else {
            if case let stringValue as String = value, let tempDouble = Double(stringValue) {
                return Self(tempDouble)
            }
            return nil
        }
        return Self(number.doubleValue)
    }
}
