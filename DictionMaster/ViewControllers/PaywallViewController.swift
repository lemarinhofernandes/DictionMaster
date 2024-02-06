//
//  PaywallViewController.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import UIKit

class PaywallViewController: UIViewController {
    private let testLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 0
        e.contentMode = .center
        e.textAlignment = .center
        e.text = "paywall"
        e.translatesAutoresizingMaskIntoConstraints = false
        e.textColor = .black
        return e
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            testLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            testLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    

    

}
