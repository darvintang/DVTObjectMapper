//
//  File.swift
//
//
//  Created by darvintang on 2021/9/19.
//

import Foundation

// MARK: - BinaryFloatingPoint

/// BinaryFloatingPoint mapping
public func <- <T: BinaryFloatingPoint>(left: inout T, right: Map) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        let value: T = toFloatPoint(right.currentValue) ?? 0.0
        FromJSON.basicType(&left, object: value)
    case .toJSON:
        left >>> right
    default: ()
    }
}

/// Optional BinaryFloatingPoint mapping
public func <- <T: BinaryFloatingPoint>(left: inout T?, right: Map) {
    switch right.mappingType {
    case .fromJSON where right.isKeyPresent:
        let value: T? = toFloatPoint(right.currentValue)
        FromJSON.basicType(&left, object: value)
    case .toJSON:
        left >>> right
    default: ()
    }
}

// MARK: - Casting Utils

/// Convert any value to `BinaryFloatingPoint`.
private func toFloatPoint<T: BinaryFloatingPoint>(_ value: Any?) -> T? {
    guard
        case let number as NSNumber = value
    else {
        if case let stringValue as String = value, let tempDouble = Double(stringValue) {
            return T(tempDouble)
        }
        return nil
    }

    return T(number.doubleValue)
}
