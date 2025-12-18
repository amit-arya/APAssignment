//
//  NetworkManager.swift
//  APAssignment
//
//  Created by Amit Arya iOS Dev on 17/12/25.
//

import Foundation
import SwiftUI

protocol NetworkManagerDelegate{
    func getImageModels(from url: String, completion: @escaping(Result<[ImageModel]?, NetworkError>) -> ())
}

class NetworkManager: NetworkManagerDelegate{
    
    func getImageModels(from url: String, completion: @escaping(Result<[ImageModel]?, NetworkError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error{
                completion(.failure(.networkError))
                return
            }
            
            if let data{
                do{
                    let decoder = JSONDecoder()
                    let imageModels = try decoder.decode([ImageModel].self, from: data)
                    completion(.success(imageModels))
                } catch{
                    completion(.failure(.invalidData))
                }
                return
            }
            
            completion(.failure(.other))
        }.resume()
    }

}
