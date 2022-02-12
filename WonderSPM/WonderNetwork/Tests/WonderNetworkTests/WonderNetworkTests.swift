import XCTest
@testable import WonderNetwork

final class WonderNetworkTests: XCTestCase {
    func testExample() throws {
        let promise = expectation(description: "Download characters completed")
        WonderNetwork.MarvelManager.share.getCharacters(limit: 1, offset: 0) { results in
            switch results {
                case .success(_):
                    promise.fulfill()
                case .failure(let error):
                    XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [promise], timeout: 5)
    }
}
