//
//  ImagesViewModel.swift
//  APAssignment
//
//  Created by Amit Arya iOS Dev on 17/12/25.
//

import Foundation
internal import Combine

class ImagesViewModel: ObservableObject{
    
    static let shared: ImagesViewModel = ImagesViewModel()
    private let networkManager: NetworkManagerDelegate
    @Published var imageModels = [ImageModel]()
    @Published var errorMessage: String?
    
    private init(networkManager: NetworkManagerDelegate = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getImageModels(from url: APIConstants){
        networkManager.getImageModels(from: url.rawValue) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let models):
                    self?.imageModels = models ?? []
                case .failure(let errorType):
                    switch errorType{
                    case .networkError:
                        self?.errorMessage = "Network Error"
                    case .invalidURL:
                        self?.errorMessage = "Invalid URL"
                    case .invalidData:
                        self?.errorMessage = "Bad data"
                    case .other:
                        self?.errorMessage = "Unknown Error"
                    }
                }
            }
        }
    }
    
}
