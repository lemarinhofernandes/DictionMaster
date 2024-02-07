//
//  MainViewController.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 05/02/24.
//

import UIKit

class MainViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    //MARK: - Views
    private let backgroundView: UIView = {
        let e = UIView()
        e.layer.cornerRadius = 20
        e.backgroundColor = .DMstandardBackground()
        return e
    }()
    
    private let languageLabel: UILabel = {
        let e = UILabel()
        e.text = "ENGLISH"
        e.textColor = .DMstandardWord()
        e.font = UIFont.DMRegular18()
        e.translatesAutoresizingMaskIntoConstraints = false
        return e
    }()
    
    private let languageImageView: UIImageView = {
        let e = UIImageView()
        let image = UIImage(named: "en-flag")
        e.image = image
        e.translatesAutoresizingMaskIntoConstraints = false
        return e
    }()
    
    private lazy var vStack: UIStackView = {
        let e = UIStackView()
        e.distribution = .equalCentering
        e.spacing = 1
        e.alignment = .center
        e.backgroundColor = .clear
        e.addArrangedSubview(languageImageView)
        e.addArrangedSubview(languageLabel)
        e.layer.cornerRadius = 20
        e.translatesAutoresizingMaskIntoConstraints = false
        return e
    }()
    
    private lazy var inputTextField: UITextField = {
        let e = UITextField()
        e.placeholder = "Type a word"
        e.contentMode = .center
        e.textAlignment = .center
        e.textColor = .DMstandardWord()
        e.font = UIFont.DMBold32()
        e.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return e
    }()
    
    private lazy var searchButton: UIButton = {
        let e = UIButton()
        e.setTitle("SEARCH", for: .normal)
        e.titleLabel?.font = UIFont.DMBold18()
        e.backgroundColor = .DMButton()
        e.contentMode = .center
        e.layer.cornerRadius = 14
        e.isHidden = true
        e.heightAnchor.constraint(equalToConstant: 64).isActive = true
        e.addTarget(self, action: #selector(handleSeach), for: .touchUpInside)
        return e
    }()
    
    
    //MARK: - Properties
    private var term: String?
    private var bottomButtonConstraint = NSLayoutConstraint()
    private var languageTopConstraint = NSLayoutConstraint()
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        
        [inputTextField, searchButton, backgroundView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        backgroundView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 125),
            backgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            vStack.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            vStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            vStack.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
        ])
        
        bottomButtonConstraint = searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomButtonConstraint.isActive = true
        
        languageTopConstraint = self.backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        languageTopConstraint.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

//MARK: - Delegates
extension MainViewController: ViewModelDelegate {
    func displayAlert(with text: String) {
        coordinator?.displayErrorAlert(with: text)
    }
    
    func callPaywallViewController() {
        coordinator?.goToPaywall()
    }
    
    func callDefinitionViewController(with definition: DefinitionModel) {
        coordinator?.goToDefinitions(with: definition)
    }
    
}

//MARK: - Helpers
extension MainViewController {
    @objc
    func handleSeach() {
        self.view.endEditing(true)
        self.viewModel.getDefinition(for: self.inputTextField.text ?? "")
    }
    
    @objc
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc
    func textFieldDidChange() {
        switch self.inputTextField.hasText {
        case true:
            self.searchButton.isHidden = false
        case false:
            self.searchButton.isHidden = true
        }
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardheight = keyboardSize.cgRectValue.height
        bottomButtonConstraint.constant = +108 - keyboardheight
        languageTopConstraint.constant = +128
        
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 128
            }
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        self.bottomButtonConstraint.constant = -12
        languageTopConstraint.constant = 0
        view.layoutSubviews()
    }
}
