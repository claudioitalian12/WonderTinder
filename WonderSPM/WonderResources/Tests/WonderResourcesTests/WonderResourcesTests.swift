import XCTest
@testable import WonderResources

final class WonderResourcesTests: XCTestCase {
    func testLoadBlackColor() throws {
        XCTAssertNotNil(WonderResources.Colors.Comics.black)
    }
    
    func testLoadWhiteColor() throws {
        XCTAssertNotNil(WonderResources.Colors.Comics.white)
    }
    
    func testLoadHeartImage() throws {
        XCTAssertNotNil(WonderResources.UI.Comics.heart)
    }
    
    func testLoadBrokenHeartImage() throws {
        XCTAssertNotNil(WonderResources.UI.Comics.brokenHeart)
    }
    
    func testLoadLoveMarvelImage() throws {
        XCTAssertNotNil(WonderResources.UI.Comics.loveMarvel)
    }
    
    func testLoadLoveMarvelImage() throws {
        XCTAssertNotNil(WonderResources.UI.Comics.loaderWonder)
    }
    
    func testLoadFontRegular() throws {
        XCTAssertNotNil(WonderResources.Fonts.Comics.get(.Regular, size: 1.0))
    }
    
    func testLoadFontMedium() throws {
        XCTAssertNotNil(WonderResources.Fonts.Comics.get(.Medium, size: 1.0))
    }
    
    func testLoadFontBold() throws {
        XCTAssertNotNil(WonderResources.Fonts.Comics.get(.Bold, size: 1.0))
    }
    
    func testLoadFontExtraBold() throws {
        XCTAssertNotNil(WonderResources.Fonts.Comics.get(.ExtraBold, size: 1.0))
    }
}
