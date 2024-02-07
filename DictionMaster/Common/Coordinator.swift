//
//  Coordinator.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 07/02/24.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
