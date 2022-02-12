//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import Alamofire
import Foundation
import WonderModel
import Realm
import RealmSwift

public extension WonderNetwork {
    class MarvelManager {
        public static var share = MarvelManager()
        public static var apikeyPublic = "9c6aa75d84913b8e8f0551e69137f060"
        public static var apikeyPrivate = "6ea1a4ec1ea290f0bdd3b760958627be28602b4b"
        
        public func getCharacters(limit: Int,
                                  offset: Int,
                                  completion: @escaping ((Result<WonderCharacter, AFError>)) -> ()) {
            let headers = HTTPHeaders(["accept":"application/json"])
            guard let url = WonderNetwork.Endpoint.getCharacters(limit: limit, offset: offset).url else {
                completion(.failure(.explicitlyCancelled))
                return
            }
            
            AF.request(url,
                       method: .get,
                       headers: headers).responseDecodable(of: WonderCharacter.self) { result in
                
                completion(result.result)
            }
        }
    }
}
