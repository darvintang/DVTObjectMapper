//
//  Operators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
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

/*
 * This file defines a new operator which is used to create a mapping between an object and a JSON key value.
 * There is an overloaded operator definition for each type of object that is supported in ObjectMapper.
 * This provides a way to add custom logic to handle specific types of objects
 */

/// Operator used to define mappings to JSON
infix operator >>>

/// Operator used to define JSON to mappings
infix operator <<<

/// Operator used for defining mappings to and from JSON
infix operator <-

// MARK: - Objects with Basic types

/// Object of Basic type
public func <<< <T>(left: inout T, right: Map) {
    if right.mappingType == .fromJSON {
        FromJSON.basicType(&left, object: right.value())
    }
}

public func >>> <T>(left: T, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.basicType(left, map: right)
    }
}

public func <- <T>(left: inout T, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional object of basic type
public func <<< <T>(left: inout T?, right: Map) {
    if right.mappingType == .fromJSON {
        FromJSON.optionalBasicType(&left, object: right.value())
    }
}

public func >>> <T>(left: T?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalBasicType(left, map: right)
    }
}

public func <- <T>(left: inout T?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Mappable Objects - <T: BaseMappable>

// Object conforming to Mappable

public func >>> <T: BaseMappable>(left: T, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.object(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout T, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.object(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout T, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional Mappable objects
public func >>> <T: BaseMappable>(left: T?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalObject(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout T?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.optionalObject(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout T?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Dictionary of Mappable objects - Dictionary<String, T: BaseMappable>

/// Dictionary of Mappable objects <String, T: Mappable>
public func >>> <T: BaseMappable>(left: [String: T], right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.objectDictionary(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout [String: T], right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.objectDictionary(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [String: T], right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func >>> <T: BaseMappable>(left: [String: T]?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalObjectDictionary(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout [String: T]?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.optionalObjectDictionary(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [String: T]?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Dictionary of Mappable objects <String, T: Mappable>
public func >>> <T: BaseMappable>(left: [String: [T]], right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.objectDictionaryOfArrays(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout [String: [T]], right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.objectDictionaryOfArrays(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [String: [T]], right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func >>> <T: BaseMappable>(left: [String: [T]]?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalObjectDictionaryOfArrays(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout [String: [T]]?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [String: [T]]?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Array of Mappable objects - Array<T: BaseMappable>

/// Array of Mappable objects
public func <<< <T: BaseMappable>(left: inout [T], right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.objectArray(&left, map: right)
    }
}

public func >>> <T: BaseMappable>(left: [T], right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.objectArray(left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [T], right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional array of Mappable objects
public func <<< <T: BaseMappable>(left: inout [T]?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.optionalObjectArray(&left, map: right)
    }
}

public func >>> <T: BaseMappable>(left: [T]?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalObjectArray(left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [T]?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Array of Array of Mappable objects - Array<Array<T: BaseMappable>>

/// Array of Array Mappable objects
public func >>> <T: BaseMappable>(left: [[T]], right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.twoDimensionalObjectArray(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout [[T]], right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.twoDimensionalObjectArray(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [[T]], right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional array of Mappable objects
public func >>> <T: BaseMappable>(left: [[T]]?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalTwoDimensionalObjectArray(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout [[T]]?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout [[T]]?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

// MARK: - Set of Mappable objects - Set<T: BaseMappable>

/// Set of Mappable objects
public func >>> <T: BaseMappable>(left: Set<T>, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.objectSet(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout Set<T>, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.objectSet(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout Set<T>, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}

/// Optional Set of Mappable objects
public func >>> <T: BaseMappable>(left: Set<T>?, right: Map) {
    if right.mappingType == .toJSON {
        ToJSON.optionalObjectSet(left, map: right)
    }
}

public func <<< <T: BaseMappable>(left: inout Set<T>?, right: Map) {
    if right.mappingType == .fromJSON, right.isKeyPresent {
        FromJSON.optionalObjectSet(&left, map: right)
    }
}

public func <- <T: BaseMappable>(left: inout Set<T>?, right: Map) {
    right.mappingType == .fromJSON ? left <<< right : left >>> right
}
