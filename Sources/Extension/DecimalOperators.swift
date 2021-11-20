//
//  DecimalOperators.swift
//
//
//  Created by darvin on 2021/9/26.
//

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
