import XCTest
@testable import DVTObjectMapper

class TestClsInt: Mappable {
    // MARK: Lifecycle
    required init?(map: Map) { }

    // MARK: Internal
    var floatToInt: Int16?
    var stringToInt: Int?
    var nilToInt: Int?

    func mapping(map: Map) {
        self.floatToInt <- map["floatToInt"]
        self.stringToInt <- map["stringToInt"]
        self.nilToInt <- map["nilToInt"]
    }
}

struct TestSrtInt: Mappable {
    // MARK: Lifecycle
    init?(map: Map) { }

    // MARK: Internal
    var floatToInt: UInt?
    var stringToInt: Int32?
    var nilToInt: Int?

    mutating func mapping(map: Map) {
        self.floatToInt <- map["floatToInt"]
        self.stringToInt <- map["stringToInt"]
        self.nilToInt <- map["nilToInt"]
    }
}

final class IntegerTests: XCTestCase {
    func test() throws {
        let dataClsSource = TestClsInt(JSONString: """
            {"floatToInt":1123.123,"stringToInt":"999999999999999.1","nilToInt":null}
            """)

        XCTAssert(dataClsSource?.floatToInt != nil)
        XCTAssertEqual(dataClsSource?.floatToInt, 1123)
        XCTAssert(dataClsSource?.stringToInt != nil)
        XCTAssertEqual(dataClsSource?.stringToInt, 999999999999999)
        XCTAssert(dataClsSource?.nilToInt == nil)
        XCTAssertEqual(dataClsSource?.nilToInt, nil)
    }
}
