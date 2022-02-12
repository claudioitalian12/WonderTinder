//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//


import UIKit

// MARK: - String
extension String {
  var localized: String {
      NSLocalizedString(self, bundle: Bundle.module, comment: "")
    }
}
