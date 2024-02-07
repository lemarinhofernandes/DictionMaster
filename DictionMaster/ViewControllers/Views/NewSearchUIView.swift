//
//  NewSearchUIView.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 07/02/24.
//

import UIKit
import Foundation

protocol NewSearchDelegate: AnyObject {
    func popScreen()
}

class NewSearchUIView: UIView {
    
    private let separator: UIView = {
        let e = UIView()
        e.backgroundColor = .DMstandardBackground()
        e.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return e
    }()
    
    private let paddingView: UIView = {
        let e = UIView()
        return e
    }()
    
    private let newSearchTitle: UILabel = {
        let e = UILabel()
        e.font = UIFont.systemFont(ofSize: 24)
        e.text = "That's it for `education`!"
        e.textColor = .DMstandardWord()
        e.font = UIFont.DMBold24()
        return e
    }()
    
    private let newSearchSubtitle: UILabel = {
        let e = UILabel()
        e.font = UIFont.DMRegular16()
        e.text = "Try another search now!"
        e.textColor = .black
        return e
    }()
    
    private lazy var newSearchButton: UIButton = {
        let e = UIButton()
        e.translatesAutoresizingMaskIntoConstraints = false
        e.setTitle("NEW SEARCH", for: .normal)
        e.titleLabel?.font = UIFont.DMBold18()
        e.backgroundColor = .DMButton()
        e.contentMode = .center
        e.layer.cornerRadius = 14
        e.heightAnchor.constraint(equalToConstant: 64).isActive = true
        e.addTarget(self, action: #selector(handleNewSeach), for: .touchUpInside)
        return e
    }()
    
    weak var delegate: NewSearchDelegate?

    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitleText(with title: String) {
        newSearchTitle.text = "That's it for \"\(title)\"!"
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        
        [paddingView, separator, newSearchButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        [newSearchTitle, newSearchSubtitle, newSearchButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            paddingView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.topAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            paddingView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 35),
            paddingView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            paddingView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            paddingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            newSearchTitle.topAnchor.constraint(equalTo: paddingView.topAnchor),
            newSearchTitle.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor),
            
            newSearchSubtitle.topAnchor.constraint(equalTo: newSearchTitle.bottomAnchor, constant: 8),
            newSearchSubtitle.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor),
            
            newSearchButton.topAnchor.constraint(equalTo: newSearchSubtitle.bottomAnchor, constant: 20),
            newSearchButton.leadingAnchor.constraint(equalTo: paddingView.leadingAnchor),
            newSearchButton.trailingAnchor.constraint(equalTo: paddingView.trailingAnchor),
            newSearchButton.bottomAnchor.constraint(equalTo: paddingView.bottomAnchor, constant: -18),
        ])
    }
    
    @objc
    func handleNewSeach() {
        delegate?.popScreen()
    }
}
