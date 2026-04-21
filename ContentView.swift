//
//  ContentView.swift
//  FinalProject (iOS bootcamp)
//
//  Created by Molly Yang on 4/16/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var searchText = ""
    @State private var includePantry = true
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                Toggle("Include Pantry Items", isOn: $includePantry)
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Finding recipes...")
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe)) {
                                RecipeRow(recipe: recipe)
                            }
                        }
                    }
                }
                
                Button("Search Recipes") {
                    Task {
                        await viewModel.search(ingredients: searchText)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
            }
            .navigationTitle("Meal Finder")
        }
    }
}
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search by ingredient...", text: $text)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { img in
                img.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(recipe.title)
                .font(.subheadline)
        }
    }
}

#Preview {
    ContentView()
}
