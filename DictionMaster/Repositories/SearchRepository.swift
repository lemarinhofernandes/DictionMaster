//
//  SearchRepository.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation
import Alamofire

class SearchRepository {
    private var baseURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    init() {
        
    }
    
    func get(_ term: String, completion: @escaping (Result<DefinitionModel, Error>) -> Void) {
        let url = baseURL + term

        let cachedTerm = UserDefaults.standard.codableObject(dataType: DefinitionModel.self, key: term)
        
        if let cachedTerm = cachedTerm {
            completion(.success(cachedTerm))
            return
        }
        
        AF.request(url).responseDecodable(of: DefinitionModel.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
                UserDefaults.standard.setCodableObject(value, key: term)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
