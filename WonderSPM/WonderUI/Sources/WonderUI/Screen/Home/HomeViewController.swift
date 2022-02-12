//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import UIKit
import WonderModel
import WonderNetwork

// MARK: - WonderUI Controller
public extension WonderUI.Controller {
    // MARK: - HomeViewController
    class HomeViewController: BaseViewController<WonderUI.View.HomeView> {
        public var didTapSummaryButton: (() -> ())?
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            self.getCharacters()
            self.setupInteraction()
        }
        
        public override func setupInteraction() {
            self.rootView?.didTapSummaryButton = { [weak self] in
                guard let self = self else { return }
                self.didTapSummaryButton?()
            }
            
            self.rootView?.updateContent = {[weak self] in
                guard let self = self else { return }
                guard let wonderCharacters = self.rootView?.model?.wonderCharacters else { return }
                
                if wonderCharacters.data.results.count == 1 {
                    self.getCharacters(offset: wonderCharacters.data.offset + 5)
                }
            }
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
        
        private func getCharacters(limit: Int = 5, offset: Int = 0) {
            WonderNetwork.MarvelManager.share.getCharacters(limit: limit, offset: offset) { [weak self] results in
                guard let self = self else { return }
                
                if var result = try? results.get() {
                    result.data.results.append(Character())
                    
                    let model = WonderUI.ViewModel.HomeViewModel(wonderCharacters: result)
                    self.rootView?.model = model
                }
            }
        }
    }
}
