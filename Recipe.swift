//
//  Recipe.swift
//  FinalProject (iOS bootcamp)
//
//  Created by Molly Yang on 4/16/26.
//
import Foundation

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount: Int
    let missedIngredientCount: Int
}
