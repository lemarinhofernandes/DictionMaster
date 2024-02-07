//
//  PaywallViewController.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import UIKit

class PaywallViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let e = UIScrollView()
        e.showsVerticalScrollIndicator = false
        e.translatesAutoresizingMaskIntoConstraints = false
        return e
    }()
    
    private let backgroundImage: UIImageView = {
        let e = UIImageView()
        e.image = UIImage(named: "backgorund")
        e.contentMode = .scaleAspectFill
        return e
    }()
    
    private let bookImage: UIImageView = {
        let e = UIImageView()
        e.image = UIImage(named: "icon")
        e.contentMode = .scaleAspectFit
        return e
    }()
    
    private let titleImage: UIImageView = {
        let e = UIImageView()
        e.image = UIImage(named: "title2")
        e.contentMode = .scaleAspectFill
        return e
    }()
    
    private let subscribeLabel: UILabel = {
        let e = UILabel()
        e.text = "Subscribe now to get unlimited \nsearches and full access to all \nfeatures."
        e.numberOfLines = 0
        e.contentMode = .center
        e.textAlignment = .center
        e.font = UIFont.systemFont(ofSize: 20)
        return e
    }()
    
    private let cancelAnytimeLabel: UILabel = {
        let e = UILabel()
        e.text = "Try 7 Days Free, then only $19,99 per year. \nCancel anytime."
        e.numberOfLines = 0
        e.contentMode = .center
        e.textAlignment = .center
        e.font = UIFont.systemFont(ofSize: 16)
        return e
    }()
    
    private lazy var subscribeButton: UIButton = {
        let e = UIButton()
        e.translatesAutoresizingMaskIntoConstraints = false
        e.setTitle("SUBSCRIBE", for: .normal)
        e.backgroundColor = .blue
        e.contentMode = .center
        e.layer.cornerRadius = 14
        e.heightAnchor.constraint(equalToConstant: 64).isActive = true
        e.addTarget(self, action: #selector(handleSubscribe), for: .touchUpInside)
        return e
    }()
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        [backgroundImage, bookImage, titleImage, subscribeLabel, cancelAnytimeLabel, subscribeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            bookImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            bookImage.centerYAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            
            titleImage.leadingAnchor.constraint(equalTo: bookImage.leadingAnchor, constant: -16),
            titleImage.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: -40),
            
            subscribeLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor),
            subscribeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 23),
            subscribeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -23),
            subscribeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            cancelAnytimeLabel.topAnchor.constraint(equalTo: subscribeLabel.bottomAnchor, constant: 36),
            cancelAnytimeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 23),
            cancelAnytimeLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -23),
            cancelAnytimeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            
            subscribeButton.topAnchor.constraint(equalTo: cancelAnytimeLabel.bottomAnchor, constant: 16),
            subscribeButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17),
            subscribeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -18),
            subscribeButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -18),
            subscribeButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }

}

extension PaywallViewController {
    @objc
    func handleSubscribe() {
        self.navigationController?.popViewController(animated: true)
    }
}
