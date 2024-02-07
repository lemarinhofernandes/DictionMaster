//
//  DefinitionViewController.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import UIKit

class DefinitionViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let e = UIScrollView()
        e.showsVerticalScrollIndicator = false
        e.translatesAutoresizingMaskIntoConstraints = false
        return e
    }()
    
    private let wordLabel: UILabel = {
        let e = UILabel()
        e.font = UIFont.systemFont(ofSize: 45)
        e.contentMode = .left
        e.textAlignment = .left
        e.textColor = .black
        return e
    }()
    
    private let pronouciationLabel: UILabel = {
        let e = UILabel()
        e.font = UIFont.systemFont(ofSize: 22)
        e.text = "/ˌedʒuˈkeɪʃn/"
        e.textColor = .black
        return e
    }()
    
    private let soundButton: UIButton = {
        let e = UIButton(type: .system)
        e.setImage(UIImage(named: "audio-speaker-on"), for: .normal)
        e.contentMode = .scaleAspectFit
        e.layer.masksToBounds = true
        e.backgroundColor = .blue
        e.heightAnchor.constraint(equalToConstant: 46).isActive = true
        e.widthAnchor.constraint(equalToConstant: 46).isActive = true
        e.layer.cornerRadius = 23
        e.tintColor = .white
        e.addTarget(self, action: #selector(handleSoundButton), for: .touchUpInside)
        return e
    }()
    
    private let definitionsStack: UIStackView = {
        let e = UIStackView()
        e.axis = .vertical
        e.spacing = 30
        return e
    }()
    
    private var soundUrl: String?
    private var definitionIndex = 0
    
    convenience init(_ value: DefinitionModelElement) {
        self.init(nibName:nil, bundle:nil)
        
        self.wordLabel.text = value.word
        self.pronouciationLabel.text = value.phonetic
        self.soundUrl = value.phonetics?[1].audio
        value.meanings?.forEach({ meaning in
            configureContainerView(partOfSpeech: meaning.partOfSpeech, definition: meaning.definitions)
        })
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupScrollView() {
        view.backgroundColor = .white
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        [wordLabel, soundButton, pronouciationLabel, definitionsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            wordLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            wordLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            
            soundButton.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 16),
            soundButton.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
            
            pronouciationLabel.leadingAnchor.constraint(equalTo: soundButton.trailingAnchor, constant: 11),
            pronouciationLabel.centerYAnchor.constraint(equalTo: soundButton.centerYAnchor),
            
            definitionsStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            definitionsStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            definitionsStack.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 25),
            definitionsStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            definitionsStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    private func configureContainerView(partOfSpeech: String?, definition: [Definition]?) {
        guard let partOfSpeech = partOfSpeech, let definition = definition else { return }
        var group: [UIView] = []
        
        for i in 0..<definition.count {
            definitionIndex += 1
            let unwrappedDefinition = definition[i].definition ?? ""
            let view = DefinitionsView(cellNum: definitionIndex, partOfSpeech: partOfSpeech, definition: unwrappedDefinition, example: definition[i].example)
            group.append(view)
        }
        
        group.forEach { view in
            definitionsStack.addArrangedSubview(view)
        }
    }
    
    @objc
    func handleSoundButton() {
        guard let url = soundUrl else { return }
        SearchViewModel.shared.playAudio(with: url)
    }
    
}
