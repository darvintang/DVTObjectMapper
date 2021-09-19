@testable import DVTObjectMapper
import XCTest

class TestClsString: Mappable {
    var intToString: String?
    var boolToString: NSString?
    var floatToString: String?
    var nilToString: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        self.intToString <- map["intToString"]
        self.boolToString <- map["boolToString"]
        self.floatToString <- map["floatToString"]
        self.nilToString <- map["nilToString"]
    }
}

struct TestSrtString: Mappable {
    var intToString: String?
    var boolToString: String?
    var floatToString: String?
    var nilToString: String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        self.intToString <- map["intToString"]
        self.boolToString <- map["boolToString"]
        self.floatToString <- map["floatToString"]
        self.nilToString <- map["nilToString"]
    }
}

final class StringTests: XCTestCase {
    func test() throws {
        let dataClsSource = TestClsString(JSONString: """
        {"intToString":123,"boolToString":true,"floatToString":123.000,"nilToString":null}
        """)
        let dataSrtSource = TestSrtString(JSONString: """
        {"intToString":123,"boolToString":true,"floatToString":123.000,"nilToString":null}
        """)

        XCTAssert(dataClsSource?.intToString != nil)
        XCTAssertEqual(dataClsSource?.intToString, "123")
        XCTAssert(dataClsSource?.boolToString != nil)
        XCTAssertEqual(dataClsSource?.boolToString, "1")
        XCTAssert(dataClsSource?.floatToString != nil)
        XCTAssertEqual(dataClsSource?.floatToString, "123")
        XCTAssert(dataClsSource?.nilToString == nil)
        XCTAssertEqual(dataClsSource?.nilToString, nil)

        XCTAssert(dataSrtSource?.intToString != nil)
        XCTAssertEqual(dataSrtSource?.intToString, "123")
        XCTAssert(dataSrtSource?.boolToString != nil)
        XCTAssertEqual(dataSrtSource?.boolToString, "1")
        XCTAssert(dataSrtSource?.floatToString != nil)
        XCTAssertEqual(dataSrtSource?.floatToString, "123")
        XCTAssert(dataSrtSource?.nilToString == nil)
        XCTAssertEqual(dataSrtSource?.nilToString, nil)
    }
}
