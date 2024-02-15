//
//  ServiceClient.swift
//  CookbookApp
//
//  Created by Matthew Klaybor on 2/12/24.
//

import Foundation

class ServiceClient {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func get<T: Decodable>(url: String) async -> Result<T, ServiceError> {
        guard let url = URL(string: url) else {
            return .failure(ServiceError.badServiceRequest)
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                return .failure(ServiceError.badServiceResponse)
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return .success(decodedData)
        } catch {
            return .failure(ServiceError.badServiceRequest)
        }
    }
    
    func getImage(url: String) async -> Result<Data, ServiceError> {
        guard let url = URL(string: url) else {
            return .failure(ServiceError.badServiceRequest)
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                return .failure(ServiceError.badServiceResponse)
            }
            
            return .success(data)
        } catch {
            return .failure(ServiceError.badServiceRequest)
        }
    }
}
