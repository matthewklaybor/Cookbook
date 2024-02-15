//
//  MediaRepository.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import SwiftUI

@Observable
class MediaRepository {
    private let imageService = ImageService()
    private var urlCache: [String] = []
    
    func loadImage(url: String) async -> Data? {
        guard !urlCache.contains(url) else { return nil }
        
        let result = await imageService.fetchImage(url: url)
        
        switch result {
            
        case .success(let data):
            urlCache.removeAll(where: { $0 == url })
            return data
        case .failure(_):
            urlCache.removeAll(where: { $0 == url })
        }
        
        if case let .success(data) = result {
            return data
        } 
        return nil
    }
    
//    private var imageCache: [String: Image] = [:]
//    func storeImage(image: Image, name: String) { imageCache[name] = image }
//    func imageCache(name: String) -> Image? { imageCache[name] }
}
