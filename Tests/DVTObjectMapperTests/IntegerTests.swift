@testable import DVTObjectMapper
import XCTest

class TestClsInt: Mappable {
    var floatToInt: Int16?
    var stringToInt: Int?
    var nilToInt: Int?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.floatToInt <- map["floatToInt"]
        self.stringToInt <- map["stringToInt"]
        self.nilToInt <- map["nilToInt"]
    }
}

struct TestSrtInt: Mappable {
    var floatToInt: UInt?
    var stringToInt: Int32?
    var nilToInt: Int?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        self.floatToInt <- map["floatToInt"]
        self.stringToInt <- map["stringToInt"]
        self.nilToInt <- map["nilToInt"]
    }
}

final class IntegerTests: XCTestCase {
    func test() throws {
        let dataClsSource = TestClsInt(JSONString: """
        {"floatToInt":1123.123,"stringToInt":"9999999999999","nilToInt":null}
        """)
        let dataSrtSource = TestSrtInt(JSONString: """
        {"floatToInt":1123.123,"stringToInt":"99999999999999","nilToInt":null}
        """)

        XCTAssert(dataClsSource?.floatToInt != nil)
        XCTAssertEqual(dataClsSource?.floatToInt, 1123)
        XCTAssert(dataClsSource?.stringToInt != nil)
        XCTAssertEqual(dataClsSource?.stringToInt, 1231)
        XCTAssert(dataClsSource?.nilToInt == nil)
        XCTAssertEqual(dataClsSource?.nilToInt, nil)

        XCTAssert(dataSrtSource?.floatToInt != nil)
        XCTAssertEqual(dataSrtSource?.floatToInt, 1123)
        XCTAssert(dataSrtSource?.stringToInt != nil)
        XCTAssertEqual(dataSrtSource?.stringToInt, 1231)
        XCTAssert(dataSrtSource?.nilToInt == nil)
        XCTAssertEqual(dataSrtSource?.nilToInt, nil)
    }
}
