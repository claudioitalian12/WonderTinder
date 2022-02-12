//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/02/22.
//

import Foundation
import Realm
import RealmSwift

public enum WonderModel {
    public class Marvel {
        public static var share = Marvel()
        private let localRealm: Realm? = try? Realm()
        
        public func saveModel<T: Object>(_ model: T) {
            guard let local = localRealm else { fatalError() }

            try? local.write {
                local.add(model)
            }
        }
        
        public func readCharacterModel(complition: (Results<Character>) -> (Void)) {
            guard let local = localRealm else { fatalError() }
            
            let objects = local.objects(Character.self)
            
            complition(objects)
        }
        
        public func deleteAll() {
            guard let local = localRealm else { fatalError() }
            
            try? local.write {
                local.deleteAll()
            }
        }
    }
}
