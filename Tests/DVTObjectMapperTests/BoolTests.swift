import XCTest
@testable import DVTObjectMapper

class TestClsBool: Mappable {
    // MARK: Lifecycle
    required init?(map: Map) { }

    // MARK: Internal
    var intToBool: Bool?
    var stringToBool: Bool?
    var nilToBool: Bool?

    func mapping(map: Map) {
        self.intToBool <- map["intToBool"]
        self.stringToBool <- map["stringToBool"]
        self.nilToBool <- map["nilToBool"]
    }
}

struct TestSrtBool: Mappable {
    // MARK: Lifecycle
    init?(map: Map) { }

    // MARK: Internal
    var intToBool: Bool?
    var stringToBool: Bool?
    var nilToBool: Bool?

    mutating func mapping(map: Map) {
        self.intToBool <- map["intToBool"]
        self.stringToBool <- map["stringToBool"]
        self.nilToBool <- map["nilToBool"]
    }
}

final class BoolTests: XCTestCase {
    func test() throws {
        let dataClsSource = TestClsBool(JSONString: """
            {"intToBool":1,"stringToBool":"YES","nilToBool":null}
            """)
        XCTAssert(dataClsSource?.intToBool != nil)
        XCTAssertEqual(dataClsSource?.intToBool, true)
        XCTAssert(dataClsSource?.stringToBool != nil)
        XCTAssertEqual(dataClsSource?.stringToBool, true)
        XCTAssert(dataClsSource?.nilToBool == nil)
    }
}
