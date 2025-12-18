//
//  ImageLoader.swift
//  APAssignment
//
//  Created by Amit Arya iOS Dev on 17/12/25.
//

import Foundation
import SwiftUI
internal import Combine

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject{
    @Published var image: UIImage?
    var imageCache = _imageCache
    
    func loadImage(from imageUrl: String) {
        if let data = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage{
            image = data
            return
        }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let url = URL(string: imageUrl) else {
                return
            }
            
            do{
                let imageData = try Data(contentsOf: url)
                let uiImage = UIImage(data: imageData)
                self?.imageCache.setObject(uiImage as AnyObject, forKey: imageUrl as AnyObject)
                DispatchQueue.main.async {
                    self?.image = uiImage
                }
            } catch{
            }
        }
    }
    
    
}
