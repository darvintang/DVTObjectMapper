@testable import DVTObjectMapper
import XCTest

class TestClsBool: Mappable {
    var intToBool: Bool?
    var stringToBool: Bool?
    var nilToBool: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.intToBool <- map["intToBool"]
        self.stringToBool <- map["stringToBool"]
        self.nilToBool <- map["nilToBool"]
    }
}

struct TestSrtBool: Mappable {
    var intToBool: Bool?
    var stringToBool: Bool?
    var nilToBool: Bool?

    init?(map: Map) {
    }

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

        let dataSrtSource = TestSrtBool(JSONString: """
        {"intToBool":1,"stringToBool":"true","nilToBool":null}
        """)

        XCTAssert(dataSrtSource?.intToBool != nil)
        XCTAssertEqual(dataSrtSource?.intToBool, true)
        XCTAssert(dataSrtSource?.stringToBool != nil)
        XCTAssertEqual(dataSrtSource?.stringToBool, true)
        XCTAssert(dataSrtSource?.nilToBool == nil)
    }
}
