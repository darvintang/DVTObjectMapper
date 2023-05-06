//
//  TransformOperators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2016-09-26.
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

// MARK: - Transforms

/// Object of Basic type with Transform
public func >>> <Transform: TransformType>(left: Transform.Object, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let value: Transform.JSON? = transform.transformToJSON(left)
        ToJSON.optionalBasicType(value, map: map)
    }
}

public func <<< <Transform: TransformType>(left: inout Transform.Object, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let value = transform.transformFromJSON(map.currentValue)
        FromJSON.basicType(&left, object: value)
    }
}

public func <- <Transform: TransformType>(left: inout Transform.Object, right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional object of basic type with Transform
public func <<< <Transform: TransformType>(left: inout Transform.Object?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let value = transform.transformFromJSON(map.currentValue)
        FromJSON.optionalBasicType(&left, object: value)
    }
}

public func >>> <Transform: TransformType>(left: Transform.Object?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let value: Transform.JSON? = transform.transformToJSON(left)
        ToJSON.optionalBasicType(value, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout Transform.Object?, right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Array of Basic type with Transform
public func <<< <Transform: TransformType>(left: inout [Transform.Object], right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
        FromJSON.basicType(&left, object: values)
    }
}

public func >>> <Transform: TransformType>(left: [Transform.Object], right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let values = toJSONArrayWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(values, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [Transform.Object], right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional array of Basic type with Transform
public func <<< <Transform: TransformType>(left: inout [Transform.Object]?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
        FromJSON.optionalBasicType(&left, object: values)
    }
}

public func >>> <Transform: TransformType>(left: [Transform.Object]?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let values = toJSONArrayWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(values, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [Transform.Object]?, right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Dictionary of Basic type with Transform
public func <<< <Transform: TransformType>(left: inout [String: Transform.Object], right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
        FromJSON.basicType(&left, object: values)
    }
}

public func >>> <Transform: TransformType>(left: [String: Transform.Object], right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let values = toJSONDictionaryWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(values, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [String: Transform.Object], right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional dictionary of Basic type with Transform
public func <<< <Transform: TransformType>(left: inout [String: Transform.Object]?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
        FromJSON.optionalBasicType(&left, object: values)
    }
}

public func >>> <Transform: TransformType>(left: [String: Transform.Object]?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let values = toJSONDictionaryWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(values, map: map)
    }
}

/// Optional dictionary of Basic type with Transform
public func <- <Transform: TransformType>(left: inout [String: Transform.Object]?, right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

// MARK: - Transforms of Mappable Objects - <T: BaseMappable>

/// Object conforming to Mappable that have transforms
public func <<< <Transform: TransformType>(left: inout Transform.Object, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let value: Transform.Object? = transform.transformFromJSON(map.currentValue)
        FromJSON.basicType(&left, object: value)
    }
}

public func >>> <Transform: TransformType>(left: Transform.Object, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let value: Transform.JSON? = transform.transformToJSON(left)
        ToJSON.optionalBasicType(value, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout Transform.Object, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional Mappable objects that have transforms
public func <<< <Transform: TransformType>(left: inout Transform.Object?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let value: Transform.Object? = transform.transformFromJSON(map.currentValue)
        FromJSON.optionalBasicType(&left, object: value)
    }
}

public func >>> <Transform: TransformType>(left: Transform.Object?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let value: Transform.JSON? = transform.transformToJSON(left)
        ToJSON.optionalBasicType(value, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout Transform.Object?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

// MARK: - Dictionary of Mappable objects with a transform - Dictionary<String, T: BaseMappable>

/// Dictionary of Mappable objects <String, T: Mappable> with a transform
public func <<< <Transform: TransformType>(left: inout [String: Transform.Object], right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON && map.isKeyPresent,
       let object = map.currentValue as? [String: Any] {
        let value = fromJSONDictionaryWithTransform(object as Any?, transform: transform) ?? left
        FromJSON.basicType(&left, object: value)
    }
}

public func >>> <Transform: TransformType>(left: [String: Transform.Object], right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let value = toJSONDictionaryWithTransform(left, transform: transform)
        ToJSON.basicType(value, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [String: Transform.Object], right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional Dictionary of Mappable object <String, T: Mappable> with a transform
public func <<< <Transform: TransformType>(left: inout [String: Transform.Object]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON && map.isKeyPresent, let object = map.currentValue as? [String: Any] {
        let value = fromJSONDictionaryWithTransform(object as Any?, transform: transform) ?? left
        FromJSON.optionalBasicType(&left, object: value)
    }
}

public func >>> <Transform: TransformType>(left: [String: Transform.Object]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let value = toJSONDictionaryWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(value, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [String: Transform.Object]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Dictionary of Mappable objects <String, T: Mappable> with a transform
public func <<< <Transform: TransformType>(left: inout [String: [Transform.Object]], right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right

    if let dictionary = map.currentValue as? [String: [Any]], map.mappingType == .fromJSON && map.isKeyPresent {
        let transformedDictionary = dictionary.map { (arg: (key: String, value: [Any])) -> (String, [Transform.Object]) in
            let (key, value) = arg
            if let jsonArray = fromJSONArrayWithTransform(value, transform: transform) {
                return (key, jsonArray)
            }
            if let leftValue = left[key] {
                return (key, leftValue)
            }
            return (key, [])
        }
        FromJSON.basicType(&left, object: transformedDictionary)
    }
}

public func >>> <Transform: TransformType>(left: [String: [Transform.Object]], right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right

    if map.mappingType == .toJSON {
        let transformedDictionary = left.map { (arg: (key: String, value: [Transform.Object])) in
            (arg.key, toJSONArrayWithTransform(arg.value, transform: transform) ?? [])
        }
        ToJSON.basicType(transformedDictionary, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [String: [Transform.Object]], right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional Dictionary of Mappable object <String, T: Mappable> with a transform
public func <<< <Transform: TransformType>(left: inout [String: [Transform.Object]]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right

    if let dictionary = map.currentValue as? [String: [Any]], map.mappingType == .fromJSON && map.isKeyPresent {
        let transformedDictionary = dictionary.map { (arg: (key: String, value: [Any])) -> (String, [Transform.Object]) in
            let (key, value) = arg
            if let jsonArray = fromJSONArrayWithTransform(value, transform: transform) {
                return (key, jsonArray)
            }
            if let leftValue = left?[key] {
                return (key, leftValue)
            }
            return (key, [])
        }
        FromJSON.optionalBasicType(&left, object: transformedDictionary)
    }
}

public func >>> <Transform: TransformType>(left: [String: [Transform.Object]]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let transformedDictionary = left?.map { (arg: (key: String, value: [Transform.Object])) in
            (arg.key, toJSONArrayWithTransform(arg.value, transform: transform) ?? [])
        }
        ToJSON.optionalBasicType(transformedDictionary, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [String: [Transform.Object]]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

// MARK: - Array of Mappable objects with transforms - Array<T: BaseMappable>

/// Array of Mappable objects
public func <<< <Transform: TransformType>(left: inout [Transform.Object], right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent,
       let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
        FromJSON.basicType(&left, object: transformedValues)
    }
}

public func >>> <Transform: TransformType>(left: [Transform.Object], right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let transformedValues = toJSONArrayWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(transformedValues, map: map)
    }
}

/// Array of Mappable objects
public func <- <Transform: TransformType>(left: inout [Transform.Object], right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional array of Mappable objects
public func <<< <Transform: TransformType>(left: inout [Transform.Object]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent {
        let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform)
        FromJSON.optionalBasicType(&left, object: transformedValues)
    }
}

public func >>> <Transform: TransformType>(left: [Transform.Object]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let transformedValues = toJSONArrayWithTransform(left, transform: transform)
        ToJSON.optionalBasicType(transformedValues, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [Transform.Object]?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

// MARK: - Array of Array of objects - Array<Array<T>>> with transforms

/// Array of Array of objects with transform
public func <<< <Transform: TransformType>(left: inout [[Transform.Object]], right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent, let original2DArray = map.currentValue as? [[Any]] {
        let transformed2DArray = original2DArray.compactMap { values in
            fromJSONArrayWithTransform(values as Any?, transform: transform)
        }
        FromJSON.basicType(&left, object: transformed2DArray)
    }
}

public func >>> <Transform: TransformType>(left: [[Transform.Object]], right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let transformed2DArray = left.compactMap { values in
            toJSONArrayWithTransform(values, transform: transform)
        }
        ToJSON.basicType(transformed2DArray, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [[Transform.Object]], right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional array of array of objects with transform
public func <<< <Transform: TransformType>(left: inout [[Transform.Object]]?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent, let original2DArray = map.currentValue as? [[Any]] {
        let transformed2DArray = original2DArray.compactMap { values in
            fromJSONArrayWithTransform(values as Any?, transform: transform)
        }
        FromJSON.optionalBasicType(&left, object: transformed2DArray)
    }
}

public func >>> <Transform: TransformType>(left: [[Transform.Object]]?, right: (Map, Transform)) {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let transformed2DArray = left?.compactMap { values in
            toJSONArrayWithTransform(values, transform: transform)
        }
        ToJSON.optionalBasicType(transformed2DArray, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout [[Transform.Object]]?, right: (Map, Transform)) {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

// MARK: - Set of Mappable objects with a transform - Set<T: BaseMappable>

/// Set of Mappable objects with transform
public func <<< <Transform: TransformType>(left: inout Set<Transform.Object>, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent, let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
        FromJSON.basicType(&left, object: Set(transformedValues))
    }
}

public func >>> <Transform: TransformType>(left: Set<Transform.Object>, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        let transformedValues = toJSONArrayWithTransform(Array(left), transform: transform)
        ToJSON.optionalBasicType(transformedValues, map: map)
    }
}

public func <- <Transform: TransformType>(left: inout Set<Transform.Object>, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

/// Optional Set of Mappable objects with transform
public func <<< <Transform: TransformType>(left: inout Set<Transform.Object>?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .fromJSON, map.isKeyPresent, let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
        FromJSON.basicType(&left, object: Set(transformedValues))
    }
}

public func >>> <Transform: TransformType>(left: Set<Transform.Object>?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    let (map, transform) = right
    if map.mappingType == .toJSON {
        if let values = left {
            let transformedValues = toJSONArrayWithTransform(Array(values), transform: transform)
            ToJSON.optionalBasicType(transformedValues, map: map)
        }
    }
}

public func <- <Transform: TransformType>(left: inout Set<Transform.Object>?, right: (Map, Transform)) where Transform.Object: BaseMappable {
    right.0.mappingType == .toJSON ? left >>> right : left <<< right
}

// MARK: - private
private func fromJSONArrayWithTransform<Transform: TransformType>(_ input: Any?, transform: Transform) -> [Transform.Object]? {
    if let values = input as? [Any] {
        #if swift(>=4.1)
            return values.compactMap { value in
                transform.transformFromJSON(value)
            }
        #else
            return values.flatMap { value in
                transform.transformFromJSON(value)
            }
        #endif
    } else {
        return nil
    }
}

private func fromJSONDictionaryWithTransform<Transform: TransformType>(_ input: Any?, transform: Transform) -> [String: Transform.Object]? {
    if let values = input as? [String: Any] {
        return values.filterMap { value in
            transform.transformFromJSON(value)
        }
    } else {
        return nil
    }
}

private func toJSONArrayWithTransform<Transform: TransformType>(_ input: [Transform.Object]?, transform: Transform) -> [Transform.JSON]? {
    #if swift(>=4.1)
        return input?.compactMap { value in
            transform.transformToJSON(value)
        }
    #else
        return input?.flatMap { value in
            transform.transformToJSON(value)
        }
    #endif
}

private func toJSONDictionaryWithTransform<Transform: TransformType>(_ input: [String: Transform.Object]?, transform: Transform) -> [String: Transform.JSON]? {
    return input?.filterMap { value in
        transform.transformToJSON(value)
    }
}
