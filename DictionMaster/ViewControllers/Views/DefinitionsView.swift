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
        e.font = UIFont.boldSystemFont(ofSize: 16)
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
        let num = String(describing: cellNum)
        definitionLabel.text = "\(num)) [\(partOfSpeech)] \(definition)"
        
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
//        var group: [UILabel] = []
//        for i in 0..<9 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "•\(example)"
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 16)
            examplesStack.addArrangedSubview(label)
            
//            group.append(label)
//        }
//        group.forEach { examplesStack.addArrangedSubview($0) }
    }
    
}
