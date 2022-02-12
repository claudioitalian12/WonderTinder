//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import Foundation
import WonderModel

// MARK: - WonderUI ViewModel
public extension WonderUI.ViewModel {
    // MARK: - HomeViewModel
    struct HomeViewModel: UIModuleViewModel {
        public var wonderCharacters: WonderCharacter?
        
        public init(wonderCharacters: WonderCharacter) {
            self.wonderCharacters = wonderCharacters
        }
    }
}
