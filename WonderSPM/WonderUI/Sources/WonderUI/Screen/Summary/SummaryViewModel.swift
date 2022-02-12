//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/02/22.
//

import Foundation
import WonderModel
import Realm
import RealmSwift

// MARK: - WonderUI ViewModel
public extension WonderUI.ViewModel {
    // MARK: - SummaryViewModel
    struct SummaryViewModel: UIModuleViewModel {
        public var wonderCharacters: [Character]?
    }
}
