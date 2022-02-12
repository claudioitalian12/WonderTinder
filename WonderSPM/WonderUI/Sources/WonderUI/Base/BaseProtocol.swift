//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import Foundation

// MARK: - UIModuleController
public protocol UIModuleController {
    func setupInteraction()
}

// MARK: - UIModuleView
public protocol UIModuleView {
    associatedtype ViewModel
    
    func setup()
    func setupInteraction()
    func style()
    func layout()
}

// MARK: - UIModuleViewModel
public protocol UIModuleViewModel {
    
}
