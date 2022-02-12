//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import Foundation
import CryptoKit

extension WonderNetwork.Endpoint {
    public var base: String {
        switch self {
        case .getCharacters:
            return "https://gateway.marvel.com"
        }
    }
    
    public var path: String {
        switch self {
        case .getCharacters(_, _):
            return "/v1/public/characters"
        }
    }
    
    public var queryItems: [URLQueryItem] {
        switch self {
        case .getCharacters(let limit, let offset):
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let ts = formatter.string(from: Date())
            let md5 = ts + WonderNetwork.MarvelManager.apikeyPrivate + WonderNetwork.MarvelManager.apikeyPublic
            let hash = Insecure.MD5.hash(data: md5.data(using: .utf8) ?? Data()).map {String(format: "%02x", $0)}
                .joined()
            
            return [URLQueryItem(name: "limit", value: String(limit)),
                    URLQueryItem(name: "offset", value: String(offset)),
                    URLQueryItem(name: "ts", value: ts),
                    URLQueryItem(name: "apikey", value: WonderNetwork.MarvelManager.apikeyPublic),
                    URLQueryItem(name: "hash", value: hash)
            ]
        }
    }
    
    public var urlComponents: URLComponents? {
        var components = URLComponents(string: base)
        components?.path = path
        components?.queryItems = queryItems
        return components
    }
    
    public var request: URLRequest? {
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
    
    public var url: URL? {
        urlComponents?.url
    }
}
