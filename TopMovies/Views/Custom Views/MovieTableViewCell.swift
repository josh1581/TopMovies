//
//  MoviesTableViewCell.swift
//  TopMovies
//
//  Created by Joshua Hoyle on 11/30/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - Outlets

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Properties
    
    var movies: Movie? {
        didSet {
            updateViews()
        }
    }
  //MARK: - Functions
    
    
     ///Updates TableViewCell Title Label and ImageView
    
    
    func updateViews() {
        guard let movies = movies else {return}
        titleLabel.text = movies.title
        MovieController.fetchPoster(movie: movies) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let poster) :
                    self.posterImageView.image = poster
                    
                case .failure(let error):
                    self.posterImageView.image = UIImage(named: "noImage")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error))")
                    
                }
            }
        }
        
    }

}//end of class
