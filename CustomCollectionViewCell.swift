//
//  CustomCollectionViewCell.swift
//  BookMeShow
//
//  Created by Aravind Devireddy on 11/09/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var movie: Movie?
    
    func configure(with movie: Movie) {
        self.movie = movie
        movieTitleLabel.text = movie.title
        
        // Load the movie poster
        if let url = URL(string: movie.poster) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        // Set the initial favorite button state
        updateFavoriteButton()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard let movie = movie else { return }
        
        // Toggle favorite state
        if FavoritesManager.shared.isMovieFavorited(movie.imdbID) {
            FavoritesManager.shared.removeFromFavorites(movie.imdbID)
        } else {
            FavoritesManager.shared.addToFavorites(movie.imdbID)
        }
        
        // Update the favorite button appearance
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        guard let movie = movie else { return }
        let isFavorited = FavoritesManager.shared.isMovieFavorited(movie.imdbID)
        if !isFavorited {
            favoriteButton.setImage(UIImage(named: "non-favorite"), for: .normal)
        } else{
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
}
