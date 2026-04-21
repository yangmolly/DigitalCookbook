//
//  RecipeView.swift
//  FinalProject (iOS bootcamp)
//
//  Created by Molly Yang on 4/17/26.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    @State private var instructions: String = "Loading..."

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    if let image = phase.image {
                        image // This is the actual image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Color.red // Indicates an error
                    } else {
                        ProgressView() // The placeholder
                    }
                }
                .cornerRadius(12)

                Text(recipe.title).font(.largeTitle).bold()

                Divider()

                Text("Instructions").font(.title2).bold()
                
                // This displays the text we fetch from the API
                Text(instructions)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
        .task {
            do {
                instructions = try await Spoonacular.fetchInstructions(for: recipe.id)
            } catch {
                instructions = "Could not load instructions."
            }
        }
    }
}
