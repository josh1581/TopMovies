//
//  MoviesTableViewController.swift
//  TopMovies
//
//  Created by Joshua Hoyle on 11/30/21.
//

import UIKit

class TopMoviesTableViewController: UITableViewController {
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    //MARK: - Properties
    
    var movies: [Movie] = []
    
    //MARK: - Functions
    
    /** Updates movies property
     
     - Throws localized description of error.
     
     - Returns an array of Movie ojbects
     
     */
    func updateViews() {
        MovieController.fetchMovies { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        let movies = movies[indexPath.row]
        cell?.movies = movies
        
        
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailVC" {
            guard let destinationVC = segue.destination as? MovieDetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let movies = self.movies[indexPath.row]
            destinationVC.movies = movies
            
        }
    }
    
    
}//end of class
