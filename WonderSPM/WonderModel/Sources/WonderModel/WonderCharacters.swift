//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/02/22.
//

import Foundation
import Realm
import RealmSwift

// MARK: - WonderCharacter
public struct WonderCharacter: Codable {
    public var code: Int
    public var status, copyright, attributionText, attributionHTML: String
    public var etag: String
    public var data: DataClass
}

// MARK: - DataClass
public struct DataClass: Codable {
    public var offset, limit, total, count: Int
    public var results: [Character]
}

// MARK: - Character
public class Character: Object, Codable {
    @Persisted public var id: Int
    @Persisted public var like: Bool = false
    @Persisted public var name: String = ""
    @Persisted public var resultDescription: String = ""
    @Persisted public var modified: String = ""
    @Persisted public var thumbnail: Thumbnail? = Thumbnail()
    @Persisted public var resourceURI: String = ""
    @Persisted public var comics: Comics? = Comics()
    @Persisted public var series: Comics? = Comics()
    @Persisted public var stories: Stories? = Stories()
    @Persisted public var events: Comics? = Comics()
    @Persisted public var urls: List<URLElement> = List()

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - Comics
public class Comics: Object, Codable {
    @Persisted public var available: Int = 0
    @Persisted public var collectionURI: String = ""
    @Persisted public var items: List<ComicsItem> = List()
    @Persisted public var returned: Int = 0
}

// MARK: - ComicsItem
public class ComicsItem: Object, Codable {
    @Persisted public var resourceURI: String = ""
    @Persisted public var name: String = ""
}

// MARK: - Stories
public class Stories: Object, Codable {
    @Persisted public var available: Int = 0
    @Persisted public var collectionURI: String = ""
    @Persisted public var items: List<StoriesItem> = List()
    @Persisted public var returned: Int = 0
}

// MARK: - StoriesItem
public class StoriesItem: Object, Codable {
    @Persisted public var resourceURI: String = ""
    @Persisted public var name: String = ""
    @Persisted public var type: String = ""
}

// MARK: - Thumbnail
public class Thumbnail: Object, Codable {
    @Persisted public var path: String = ""
    @Persisted public var thumbnailExtension: String = ""

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
public class URLElement: Object, Codable {
    @Persisted public var type: String = ""
    @Persisted public var url: String = ""
}
