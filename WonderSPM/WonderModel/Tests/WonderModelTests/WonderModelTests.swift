import XCTest
@testable import WonderModel

final class WonderModelTests: XCTestCase {
    
    func testRealmSaveCharacter() throws {
        let character = Character()
        WonderModel.Marvel.share.saveModel(character)
        
        WonderModel.Marvel.share.readCharacterModel { result in
            XCTAssertNotEqual(result.count, 0)
        }
    }
    
    func testRealmDeleate() throws {
        WonderModel.Marvel.share.deleteAll()
        
        WonderModel.Marvel.share.readCharacterModel { result in
            XCTAssertEqual(result.count, 0)
        }
    }
}
