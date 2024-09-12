//
//  ApiParameterDetails.swift
//  BookMeShow
//
//  Created by Aravind Devireddy on 05/09/24.
//

import Foundation

let baseURL = "http://www.omdbapi.com/"
let apiKey = "64e5c48a"

//MARK: - API Request Data
struct MetaData: Codable {
    let ver, ts, txn : String
}

class FavoritesManager {
    
    static let shared = FavoritesManager()
    
    private let favoritesKey = "favoritedMovies"
    
    // Retrieve favorited movies from UserDefaults
    func getFavoritedMovies() -> [String] {
        return UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }
    
    // Check if a movie is favorited
    func isMovieFavorited(_ imdbID: String) -> Bool {
        let favoritedMovies = getFavoritedMovies()
        return favoritedMovies.contains(imdbID)
    }
    
    // Add a movie to favorites
    func addToFavorites(_ imdbID: String) {
        var favoritedMovies = getFavoritedMovies()
        favoritedMovies.append(imdbID)
        UserDefaults.standard.set(favoritedMovies, forKey: favoritesKey)
    }
    
    // Remove a movie from favorites
    func removeFromFavorites(_ imdbID: String) {
        var favoritedMovies = getFavoritedMovies()
        if let index = favoritedMovies.firstIndex(of: imdbID) {
            favoritedMovies.remove(at: index)
        }
        UserDefaults.standard.set(favoritedMovies, forKey: favoritesKey)
    }
}
