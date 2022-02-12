//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import Foundation

// MARK: - Navigator
protocol Navigator {
    associatedtype Destination
    
    init(initialDestination: Destination)
    
    func navigate(to destination: Destination)
    func present(to destination: Destination)
}
