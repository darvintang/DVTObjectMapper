@testable import DVTObjectMapper
import XCTest

class TestClsFloat: Mappable {
    var intToFloat: CGFloat?
    var stringToFloat: Float?
    var nilToFloat: Float?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.intToFloat <- map["intToFloat"]
        self.stringToFloat <- map["stringToFloat"]
        self.nilToFloat <- map["nilToFloat"]
    }
}

struct TestSrtFloat: Mappable {
    var intToFloat: Float?
    var stringToFloat: Double?
    var nilToFloat: Float?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        self.intToFloat <- map["intToFloat"]
        self.stringToFloat <- map["stringToFloat"]
        self.nilToFloat <- map["nilToFloat"]
    }
}

final class FloatTests: XCTestCase {
    func test() throws {
        let dataClsSource = TestClsFloat(JSONString: """
        {"intToFloat":1123,"stringToFloat":"1231.124213123","nilToFloat":null}
        """)
        let dataSrtSource = TestSrtFloat(JSONString: """
        {"intToFloat":1123,"stringToFloat":"1231.124213123","nilToFloat":null}
        """)

        XCTAssert(dataClsSource?.intToFloat != nil)
        XCTAssertEqual(dataClsSource?.intToFloat, 1123)
        XCTAssert(dataClsSource?.stringToFloat != nil)
        XCTAssertEqual(dataClsSource?.stringToFloat, 1231.124213123)
        XCTAssert(dataClsSource?.nilToFloat == nil)
        XCTAssertEqual(dataClsSource?.nilToFloat, nil)

        XCTAssert(dataSrtSource?.intToFloat != nil)
        XCTAssertEqual(dataSrtSource?.intToFloat, 1123)
        XCTAssert(dataSrtSource?.stringToFloat != nil)
        XCTAssertEqual(dataSrtSource?.stringToFloat, 1231.124213123)
        XCTAssert(dataSrtSource?.nilToFloat == nil)
        XCTAssertEqual(dataSrtSource?.nilToFloat, nil)
    }
}
