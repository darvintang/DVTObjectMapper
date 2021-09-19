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

final class ExpressibleByStringLiteralTests: XCTestCase {
    func test() throws {
        let dataClsSource = TestClsString(JSONString: """
        {"intToString":123,"boolToString":true,"floatToString":123.12,"nilToString":null}
        """)
        let dataSrtSource = TestSrtString(JSONString: """
        {"intToString":123,"boolToString":true,"floatToString":123.12,"nilToString":null}
        """)

        XCTAssert(dataClsSource?.intToString != nil)
        XCTAssert(dataClsSource?.boolToString != nil)
        XCTAssert(dataClsSource?.floatToString != nil)
        XCTAssert(dataClsSource?.nilToString == nil)

        XCTAssert(dataSrtSource?.intToString != nil)
        XCTAssert(dataSrtSource?.boolToString != nil)
        XCTAssert(dataSrtSource?.floatToString != nil)
        XCTAssert(dataSrtSource?.nilToString == nil)
    }
}
