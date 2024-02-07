//
//  MainCoordinator.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 07/02/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDefinitions(with definition: DefinitionModel) {
        var soundUrl = String()
        
        definition[0].phonetics?.forEach {
            if let phonetic = $0.audio, !phonetic.isEmpty {
                soundUrl = phonetic
            }
        }
        
        let vc = DefinitionViewController(definition[0], url: soundUrl)
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPaywall() {
        let vc = PaywallViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayErrorAlert(with text: String) {
        let alert = UIAlertController(title: "Warning", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func popToRoot() {
        navigationController.popViewController(animated: true)
    }
    
}
