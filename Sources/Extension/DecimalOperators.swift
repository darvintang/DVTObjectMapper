//
//  DecimalOperators.swift
//  DVTObjectMapper
//
//  Created by darvin on 2021/9/26.
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

// MARK: - Decimal

/// Decimal mapping
public func <- (left: inout Decimal, right: Map) {
    switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            let value = toDecimal(right.currentValue) ?? 0
            FromJSON.basicType(&left, object: value)
        case .toJSON:
            left >>> right
        default: ()
    }
}

/// Optional Decimal mapping
public func <- (left: inout Decimal?, right: Map) {
    switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            let value = toDecimal(right.currentValue)
            FromJSON.basicType(&left, object: value)
        case .toJSON:
            left >>> right
        default: ()
    }
}

// MARK: - Casting Utils

private func toDecimal(_ value: Any?) -> Decimal? {
    guard
        case let decimalValue as Decimal = value
    else {
        if let tempValue = value {
            return Decimal(string: "\(tempValue)")
        }
        return nil
    }

    return decimalValue
}
