//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-21.
//

import Foundation
import SwiftUI


enum Endpoints: StringLiteralType {
    case chuckNorris = "https://api.chucknorris.io/jokes/random"
}
 
struct Network {
    func fetch<T: Codable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else  {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}

extension URL
{
    var parameters: [String: String?]?
    {
        if  let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems
        {
            var parameters = [String: String?]()
            for item in queryItems {
                parameters[item.name] = item.value
            }
            return parameters
        } else {
            return nil
        }
    }
}


