//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/02/22.
//

import UIKit
import WonderModel
import Realm
import RealmSwift

// MARK: - WonderUI Controller
public extension WonderUI.Controller {
    // MARK: - SummaryViewController
    class SummaryViewController: BaseViewController<WonderUI.View.SummaryView> {
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            self.getSaveElements()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
                                              .foregroundColor: UIColor.white]

            navigationController?.navigationBar.barTintColor = .clear
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.tintColor = .white
        }
        
        private func getSaveElements() {
            WonderModel.Marvel.share.readCharacterModel { [weak self] results in
                guard let self = self else { return }
                let revese: [Character] = results.reversed()
                let model = WonderUI.ViewModel.SummaryViewModel(wonderCharacters: revese)
                self.rootView?.model = model
            }
        }
    }
}
