//
//  Spoonacular.swift
//  FinalProject (iOS bootcamp)
//
//  Created by Molly Yang on 4/16/26.
//

import SwiftUI

class Spoonacular {
    private static let apiKey = "3e19bcffbbe945248ae1ad7cc274b2e3"
    
    static func fetchRecipes(for ingredients: String) async throws -> [Recipe] {
            let formatted = ingredients.replacingOccurrences(of: " ", with: "")
            let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(formatted)&number=10&apiKey=\(apiKey)"
            
            guard let url = URL(string: urlString) else { throw URLError(.badURL) }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Recipe].self, from: data)
        }

    static func fetchInstructions(for id: Int) async throws -> String {
        let urlString = "https://api.spoonacular.com/recipes/\(id)/information?apiKey=3e19bcffbbe945248ae1ad7cc274b2e3"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        struct DetailResponse: Codable { let instructions: String? }
        let decoded = try JSONDecoder().decode(DetailResponse.self, from: data)
        
        return decoded.instructions ?? "No instructions provided."
    }
}
