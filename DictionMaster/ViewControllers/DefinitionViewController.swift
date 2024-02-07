//
//  DefinitionViewController.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import UIKit

class DefinitionViewController: UIViewController {
    //MARK: - Views
    private let scrollView: UIScrollView = {
        let e = UIScrollView()
        e.showsVerticalScrollIndicator = false
        return e
    }()
    
    private let marginView: UIView = {
        let e = UIView()
        e.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return e
    }()
    
    private let wordLabel: UILabel = {
        let e = UILabel()
        e.font = UIFont.DMBold45()
        e.textColor = .DMstandardWord()
        e.contentMode = .left
        e.textAlignment = .left
        e.textColor = .black
        return e
    }()
    
    private let pronouciationLabel: UILabel = {
        let e = UILabel()
        e.font = UIFont.DMBold22()
        e.textColor = .DMalternativeWord()
        return e
    }()
    
    private let soundButton: UIButton = {
        let e = UIButton(type: .system)
        e.setImage(UIImage(named: "audio-speaker-on"), for: .normal)
        e.contentMode = .scaleAspectFit
        e.layer.masksToBounds = true
        e.backgroundColor = .DMButton()
        e.heightAnchor.constraint(equalToConstant: 46).isActive = true
        e.widthAnchor.constraint(equalToConstant: 46).isActive = true
        e.layer.cornerRadius = 23
        e.tintColor = .white
        e.addTarget(self, action: #selector(handleSoundButton), for: .touchUpInside)
        return e
    }()
    
    /// aqui eu poderia ter usado uma tableview, mas como nao teria nenhuma interação com as celulas, optei pela stackview
    private let definitionsStack: UIStackView = {
        let e = UIStackView()
        e.axis = .vertical
        e.spacing = 30
        return e
    }()
    
    private let newSearchView = NewSearchUIView()
    
    //MARK: - Properties
    private var soundUrl: String?
    private var definitionIndex = 0
    weak var coordinator: MainCoordinator?
    
    //MARK: - Lifecycle
    convenience init(_ value: DefinitionModelElement, url soundUrl: String) {
        self.init(nibName:nil, bundle:nil)
        let title = value.word ?? ""
        
        self.wordLabel.text = title.capitalized
        self.pronouciationLabel.text = value.phonetic
        self.soundUrl = soundUrl
        self.newSearchView.setTitleText(with: title)
        
        configureMeanings(with: value.meanings)
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
    
    //MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        newSearchView.delegate = self
        
        [scrollView, newSearchView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: newSearchView.topAnchor),
            
            newSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newSearchView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        setupScrollView()
        
    }
    
    private func setupScrollView() {
        [wordLabel, soundButton, pronouciationLabel, definitionsStack, marginView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            wordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            soundButton.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 16),
            soundButton.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            
            pronouciationLabel.leadingAnchor.constraint(equalTo: soundButton.trailingAnchor, constant: 11),
            pronouciationLabel.centerYAnchor.constraint(equalTo: soundButton.centerYAnchor),
            
            definitionsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            definitionsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            definitionsStack.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 25),
            definitionsStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            marginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            marginView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            marginView.topAnchor.constraint(equalTo: definitionsStack.bottomAnchor),
            marginView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
}

//MARK: - Helpers
extension DefinitionViewController {
    private func configureMeanings(with meanings: [Meaning]?) {
        guard let meanings = meanings else { return }
        
        meanings.forEach({ meaning in
            configureContainerView(partOfSpeech: meaning.partOfSpeech, definition: meaning.definitions)
        })
    }
    
    private func configureContainerView(partOfSpeech: String?, definition: [Definition]?) {
        guard let partOfSpeech = partOfSpeech, let definition = definition else { return }
        var group: [UIView] = []
        
        definition.forEach { definition in
            definitionIndex += 1
            let unwrappedDefinition = definition.definition ?? ""
            let view = DefinitionsView(cellNum: definitionIndex, partOfSpeech: partOfSpeech, definition: unwrappedDefinition, example: definition.example)
            group.append(view)
        }
        
        group.forEach { view in
            definitionsStack.addArrangedSubview(view)
        }
    }
}

extension DefinitionViewController {
    @objc
    func handleSoundButton() {
        guard let url = soundUrl else { return }
        SearchViewModel.shared.playAudio(with: url)
    }
    
}

//MARK: - Delegates
extension DefinitionViewController: NewSearchDelegate {
    func popScreen() {
        self.coordinator?.popToRoot()
    }
    
}
