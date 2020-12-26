import XCTest
@testable import SharedPips

final class SharedPipsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SharedPips().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
