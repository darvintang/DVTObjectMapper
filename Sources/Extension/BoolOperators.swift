//
//  File.swift
//
//
//  Created by darvintang on 2021/9/19.
//

import Foundation

public protocol AllBoolProtocol: ExpressibleByBooleanLiteral {
}

extension Bool: AllBoolProtocol {}
extension ObjCBool: AllBoolProtocol {}

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
