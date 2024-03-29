//
//  DefinitionsView.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import UIKit

class DefinitionsView: UIView {
    
    private let definitionLabel: UILabel = {
        let e = UILabel()
        e.numberOfLines = 0
        e.font = UIFont.DMBold16()
        e.textColor = .DMstandardWord()
        return e
    }()
    
    private let examplesStack: UIStackView = {
        let e = UIStackView()
        e.axis = .vertical
        e.spacing = 0
        return e
    }()
    
    init(cellNum: Int, partOfSpeech: String, definition: String, example: String?) {
        super.init(frame: .zero)
        setupUI()
        setupDefinitionLabel(cellNum, partOfSpeech, definition)
        setupStackSubviews(example: example)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        [definitionLabel, examplesStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            definitionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            definitionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            definitionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            examplesStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            examplesStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            examplesStack.topAnchor.constraint(equalTo: self.definitionLabel.bottomAnchor, constant: 16),
            examplesStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            examplesStack.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
        
    }
    
    func setupStackSubviews(example: String?) {
        guard let example = example else { return }
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "• \(example)"
            label.numberOfLines = 0
            label.font = UIFont.DMRegular16()
        label.textColor = .DMstandardWord()
            examplesStack.addArrangedSubview(label)
    }
    
}

extension DefinitionsView {
    func setupDefinitionLabel(_ num: Int, _ partOfSpeech: String, _ definition: String) {
        let num = String(describing: num)
        
        let mainString = "\(num)) [\(partOfSpeech)] \(definition)"
        let attributedText = NSMutableAttributedString(string: mainString)
        let fontSizeAttribute = [NSAttributedString.Key.foregroundColor: UIColor.DMstandardWord()]
        attributedText.addAttributes(fontSizeAttribute, range: NSRange(location: 0, length: mainString.count))
        
        let blueCollor = [NSAttributedString.Key.foregroundColor: UIColor.DMalternativeWord()]
        let unlimited = (mainString as NSString).range(of: "[\(partOfSpeech)]")
        attributedText.addAttributes(blueCollor, range: unlimited)
        
        definitionLabel.attributedText = attributedText
    }
}
