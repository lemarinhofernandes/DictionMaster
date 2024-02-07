//
//  ButtonFactory.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 07/02/24.
//

import UIKit

extension UIButton {
    static func buttonFactory(title: String, _ target: Any?, action: Selector, isHidden: Bool) -> UIButton {
        let e = UIButton()
        e.setTitle(title, for: .normal)
        e.titleLabel?.font = UIFont.DMBold18()
        e.backgroundColor = .DMButton()
        e.contentMode = .center
        e.layer.cornerRadius = 14
        e.isHidden = isHidden
        e.heightAnchor.constraint(equalToConstant: 64).isActive = true
        e.addTarget(target, action: action, for: .touchUpInside)
        return e
    }
}
