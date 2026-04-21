//
//  RecipeViewModel.swift
//  FinalProject (iOS bootcamp)
//
//  Created by Molly Yang on 4/16/26.
//

import SwiftUI
import Combine

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    
    func search(ingredients: String) async {
        isLoading = true
        do {
            self.recipes = try await Spoonacular.fetchRecipes(for: ingredients)
        } catch {
            print("Request failed: \(error)")
        }
        isLoading = false
    }
}
