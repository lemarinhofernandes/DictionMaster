//
//  UserDefaultsExtension.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation

extension UserDefaults {
    func setCodableObject<T: Codable>(_ data: T?, key: String?) {
        let encoded = try? JSONEncoder().encode(data)
        let finalKey = key ?? "RequestCache"
        set(encoded, forKey: finalKey)
    }
    
    func codableObject<T : Codable>(dataType: T.Type, key: String?) -> T? {
        let finalKey = key ?? "RequestCache"
        guard let userDefaultData = data(forKey: finalKey) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
