//
//  NetworkManager.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func get<T:Codable>(ofType: T.Type,requestURL: String ,requestAction: String, completion: @escaping (Result<T?, Error>) -> Void)
    func formRequest (url: String) -> URLRequest?
}

final class NetworkManager: NetworkManagerProtocol {
    private var requestURL: String!
    private var requestAction: String!
    
    func get<T:Codable>(ofType: T.Type, requestURL: String ,requestAction: String, completion: @escaping (Result<T?, Error>) -> Void){
        guard let request = formRequest(url: requestURL + requestAction) else {return}
        URLSession.shared.dataTask(with: request){data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(ofType, from: data!)
                completion(.success(obj))
                print("suc")
            }
            catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func formRequest(url: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        let request = URLRequest(url: url)
        
        return request
    }
}
