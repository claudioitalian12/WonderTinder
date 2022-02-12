//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import UIKit

// MARK: - BaseViewController
public class BaseViewController <V: BaseView>: UIViewController, UIModuleController {
    public var loader: UIAlertController?
    public var rootView: V? {
      if let view = self.view as? V {
        return view
      }
        return nil
    }
    
    override public func loadView() {
        let view = V()
        self.view = view
    }
    
    public func setupInteraction() {}
}

// MARK: - BaseView
public class BaseView: UIView, UIModuleView {
    public typealias ViewModel = UIModuleViewModel
    
    public func setup() {}
    
    public func setupInteraction() {}
    
    public func style() {}
    
    public func layout() {}
}
