//
//  SearchRepository.swift
//  DictionMaster
//
//  Created by Luís Eduardo Marinho Fernandes on 06/02/24.
//

import Foundation
import Alamofire

final class SearchRepository {
    func get(_ term: String, completion: @escaping (Result<DefinitionModel, ErrorsEnum>) -> Void) {
        let url = DMConstants.baseUrl + term
        let cachedTerm = UserDefaults.standard.codableObject(dataType: DefinitionModel.self, key: term)
        
        if let cachedTerm = cachedTerm {
            completion(.success(cachedTerm))
            return
        }
        
        switch shouldMakeRequest() {
        case true:
            AF.request(url).responseDecodable(of: DefinitionModel.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    UserDefaults.standard.setCodableObject(value, key: term)
                case .failure(_):
                    completion(.failure(.NetworkError))
                }
            }
        case false:
            completion(.failure(.LimitError))
            break
        }
        
    }
    
    private func shouldMakeRequest() -> Bool {
        let requestCache = UserDefaults.standard.codableObject(dataType: RequestCache.self, key: DMConstants.kCache)
        let timesCalled = requestCache?.timesCalled ?? 0
        
        guard let _ = requestCache else {
            increaseRequestCall(1)
            return true
        }
        
        if timesCalled >= 5 {
            return false
        }
        
        increaseRequestCall(timesCalled+1)
        return true
    }
    
    private func increaseRequestCall(_ timesCalled: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy"
        let date = dateFormatter.string(from: Date())

        let codableObject = RequestCache(date: date, timesCalled: timesCalled)
        UserDefaults.standard.setCodableObject(codableObject, key: DMConstants.kCache)
    }
}
