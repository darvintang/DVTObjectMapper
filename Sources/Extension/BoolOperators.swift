//
//  BoolOperators.swift
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

public protocol AllBoolProtocol: ExpressibleByBooleanLiteral { }

extension Bool: AllBoolProtocol { }
extension ObjCBool: AllBoolProtocol { }

// MARK: - AllBoolProtocol

/// AllBoolProtocol mapping
public func <- <T: AllBoolProtocol>(left: inout T, right: Map) {
    switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            let value: T = toBoolProtocol(right.currentValue) ?? false
            FromJSON.basicType(&left, object: value)
        case .toJSON:
            left >>> right
        default: ()
    }
}

/// Optional AllBoolProtocol mapping
public func <- <T: AllBoolProtocol>(left: inout T?, right: Map) {
    switch right.mappingType {
        case .fromJSON where right.isKeyPresent:
            let value: T? = toBoolProtocol(right.currentValue)
            FromJSON.basicType(&left, object: value)
        case .toJSON:
            left >>> right
        default: ()
    }
}

// MARK: - Casting Utils

/// Convert any value to `AllBoolProtocol`.
private func toBoolProtocol<T: AllBoolProtocol>(_ value: Any?) -> T? {
    guard
        case let boolValue as Bool = value
    else {
        if let tempValue = value as? String {
            if let index = ["yes", "no", "true", "false", "1", "0"].firstIndex(of: tempValue.lowercased()) {
                return (index % 2 == 0) as? T
            }
        }
        return nil
    }

    return boolValue as? T
}
