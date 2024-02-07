//
//  PaywallViewController.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import UIKit

class PaywallViewController: UIViewController {
    //MARK: - Views
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
        e.numberOfLines = 0
        e.contentMode = .center
        e.textAlignment = .center
        e.font = UIFont.DMBold20()
        return e
    }()
    
    private let cancelAnytimeLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 0
        e.contentMode = .center
        e.textAlignment = .center
        e.textColor = .DMstandardWord()
        return e
    }()
    
    private let subscribeButton = UIButton.buttonFactory(title: "SUBSCRIBE", self, action: #selector(handleSubscribe), isHidden: false)
    
    //MARK: - Properties
    weak var coordinator: MainCoordinator?
    
    //MARK: - Lifecycle
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
    
    //MARK: - Lifecycle
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
        
        setCancelAnytimeLabel()
        setSubscribeLabel()
    }
    
    func setSubscribeLabel() {
        let mainString = "Subscribe now to get unlimited \nsearches and full access to all \nfeatures."
        let attributedText = NSMutableAttributedString(string: mainString)
        let colorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.DMstandardWord()]
        attributedText.addAttributes(colorAttribute, range: NSRange(location: 0, length: mainString.count))
        
        let blueCollor = [NSAttributedString.Key.foregroundColor: UIColor.DMButton()]
        let unlimited = (mainString as NSString).range(of: "unlimited")
        attributedText.addAttributes(blueCollor, range: unlimited)
        
        let allFeatures = (mainString as NSString).range(of: "all \nfeatures.")
        attributedText.addAttributes(blueCollor, range: allFeatures)
        
        subscribeLabel.attributedText = attributedText
    }
    
    func setCancelAnytimeLabel() {
        let mainString = "Try 7 Days Free, then only $19,99 per year. \nCancel anytime."
        let attributedText = NSMutableAttributedString(string: mainString)
        let fontSizeAttribute = [NSAttributedString.Key.font: UIFont.DMRegular16()]
        attributedText.addAttributes(fontSizeAttribute, range: NSRange(location: 0, length: mainString.count))
        
        let boldAttribute = [NSAttributedString.Key.font: UIFont.DMBold16()]
        let tryRange = (mainString as NSString).range(of: "Try 7 Days Free")
        attributedText.addAttributes(boldAttribute, range: tryRange)
        
        let priceRange = (mainString as NSString).range(of: "$19,99")
        attributedText.addAttributes(boldAttribute, range: priceRange)
        cancelAnytimeLabel.attributedText = attributedText
    }

}

//MARK: - Helpers
extension PaywallViewController {
    @objc
    func handleSubscribe() {
        coordinator?.popToRoot()
    }
}
