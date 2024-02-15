//
//  ImageService.swift
//  Cookbook
//
//  Created by Matthew Klaybor on 2/13/24.
//

import Foundation

protocol ImageServiceProtocol {
    func fetchImage(url: String) async -> Result<Data, ServiceError>
}

class ImageService: ServiceClient, ImageServiceProtocol {
    func fetchImage(url: String) async -> Result<Data, ServiceError> {
        await getImage(url: url)
    }
}
