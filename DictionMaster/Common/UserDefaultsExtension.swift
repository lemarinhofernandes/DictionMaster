//
//  UserDefaultsExtension.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation

extension UserDefaults {
    func setCodableObject<T: Codable>(_ data: T?, key: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: key)
    }
    
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
