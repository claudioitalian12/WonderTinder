//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import UIKit
import WonderUI

// MARK: - WonderProtocol Navigator
extension WonderProtocol.Navigator {
    // MARK: - AppNavigator
    public class AppNavigator: Navigator {
        public var navigationController: UINavigationController?
        
        public enum Destination {
            case home
            case summary
        }
        
        required public init(initialDestination: Destination) {
            let viewController = makeViewController(for: initialDestination)
            self.navigationController = UINavigationController(rootViewController: viewController)
        }
        
        public func navigate(to destination: Destination) {
            let viewController = makeViewController(for: destination)
            navigationController?.pushViewController(viewController, animated: true)
        }
        
        public func present(to destination: Destination) {
            let viewController = makeViewController(for: destination)
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.present(viewController, animated: true)
        }
        
        private func makeViewController(for destination: Destination) -> UIViewController {
            switch destination {
            case .home:
                let vc = WonderUI.Controller.HomeViewController()
                vc.didTapSummaryButton = { [weak self] in
                    guard let self = self else { return }
                    self.navigate(to: .summary)
                }
                return vc
            case .summary:
                return WonderUI.Controller.SummaryViewController()
            }
        }
    }
}
