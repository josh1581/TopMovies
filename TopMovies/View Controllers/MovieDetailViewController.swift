//
//  MovieDetailViewController.swift
//  TopMovies
//
//  Created by Joshua Hoyle on 11/30/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Properties
    var movies: Movie?
       
    
    
    //MARK: - Functions
    
    
     ///Updates TableView Title Label, Overview TextView, and ImageView
     
    
    func updateViews() {
        guard let movies = movies else {return}
        titleLabel.text = movies.title
        overviewTextView.text = movies.overview
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
