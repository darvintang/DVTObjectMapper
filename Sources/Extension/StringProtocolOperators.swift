//
//  StringProtocolOperators.swift
//  ObjectMapper
//
//  Created by Suyeol xt-input on 06/07/2019.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2018 Tristan Himmelman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public protocol AllStringProtocol: ExpressibleByStringLiteral {
}

extension NSString: AllStringProtocol { }
extension String: AllStringProtocol { }
extension Substring: AllStringProtocol { }

// MARK: - AllStringProtocol

/// AllStringProtocol mapping
public func <- <T: AllStringProtocol>(left: inout T, right: Map) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        let value: T = toStringProtocol(right.currentValue) ?? ""
        FromJSON.basicType(&left, object: value)
    case .toJSON:
        left >>> right
    default: ()
    }
}

/// Optional AllStringProtocol mapping
public func <- <T: AllStringProtocol>(left: inout T?, right: Map) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        let value: T? = toStringProtocol(right.currentValue)
        FromJSON.basicType(&left, object: value)
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK: - Casting Utils

/// Convert any value to `AllStringProtocol`.
private func toStringProtocol<T: AllStringProtocol>(_ value: Any?) -> T? {
    guard
        case let stringValue as String = value
    else {
        if let tempValue = value {
            return "\(tempValue)" as? T
        }
        return nil
    }

    return stringValue as? T
}
