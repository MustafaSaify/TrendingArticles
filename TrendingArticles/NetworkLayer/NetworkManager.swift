//
//  NetworkManager.swift
//  TrendingArticles
//
//  Created by Mustafa.saify on 23/10/2022.
//
import Foundation

enum NetworkError: Error {
    case serverError(_ error: Error?)
    case invalidData
}

protocol  NetworkContractor {
    func sendRequest<T: Codable>(request: NetworkRequest, completion: @escaping(Swift.Result<T, Error>) -> Void)
}

struct NetworkManager: NetworkContractor {
    
    func sendRequest<T: Codable>(request: NetworkRequest, completion: @escaping(Swift.Result<T, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
            if let _error = error {
                completion(Result.failure(NetworkError.serverError(_error)))
                return
            }
            do{
                let response = try JSONDecoder().decode(T.self, from: data!)
                completion(Result.success(response))
            }
            catch(let error) {
                print(error)
                completion(Result.failure(NetworkError.invalidData))
            }
            
//            guard let data = data, let response = try? JSONDecoder().decode(T.self, from: data) else {
//                completion(Result.failure(NetworkError.invalidData))
//                return
//            }
//            completion(Result.success(response))
        }.resume()
    }
}
