//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/02/22.
//

import UIKit

// MARK: - WonderResources UI
extension WonderResources.UI {
    // MARK: - Comics
    public struct Comics {
        public init() { }
        public static let loaderWonder = UIImage(named: "loaderWonder\(Int.random(in: 1...4))", in: Bundle.module, compatibleWith: nil)
        public static let brokenHeart = UIImage(named: "broken-heart", in: Bundle.module, compatibleWith: nil)
        public static let loveMarvel = UIImage(named: "love-marvel", in: Bundle.module, compatibleWith: nil)
        public static let heart = UIImage(named: "heart", in: Bundle.module, compatibleWith: nil)
    }
}
