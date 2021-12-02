//
//  MoviesController.swift
//  TopMovies
//
//  Created by Joshua Hoyle on 11/30/21.
//

import UIKit

class MovieController {
    
    //MARK: - Properties
    
    static let baseURL = URL(string: "https://api.themoviedb.org/3/trending/movie/week")
    static let apiKey = "api_key"
    /// Insert API Key Here
    static let apiKeyKey = ""
   
   
    //MARK: - Functions
    
    /** Fetches a list of trending/top movies from TMDB(The Movie Data Base) API.
     
     - Throws MovieError.invalidURL if the URL is invalid.
     - Throws MovieError.thrownError with localized descrition for thrown error.
     - Throws MovieError.noData if the server responds with no data.
    
     - Returns a Movie object.
     */
    
    static func fetchMovies(completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        guard let baseURL = baseURL
        else {return completion(.failure(.invalidURL))}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiKeyQuery = URLQueryItem(name: apiKey, value: apiKeyKey)
        components?.queryItems = [apiKeyQuery]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print ("MOVIE STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let movie = try
                JSONDecoder().decode(MoviesTopLevelObject.self, from: data)
                completion(.success(movie.results))
            }catch{
                completion(.failure(.thrownError(error)))
            }
        }.resume()
        
        
    }
    
    /** Fetches an image  from  TMDB(The Movie Data Base) API for the corresponding Movie object using the poster variable.
     
     - Throws MovieError.invalidURL if the URL is invalid.
     - Throws MovieError.thrownError with localized descrition for thrown error.
     - Throws MovieError.noData if the server responds with no data.
     
     - Returns a UImage for the corresponding Movie object.
     */
    
    static func fetchPoster(movie: Movie, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        let basePosterURL = URL (string: "https://image.tmdb.org/t/p/w500")
        guard let movieImageString = movie.poster,
              let posterURL = basePosterURL?.appendingPathComponent(movieImageString) else
              {return}
        print(posterURL)
        URLSession.shared.dataTask(with: posterURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                
                print("POSTER STATUS CODE: \(response.statusCode)")
                
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let poster = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            completion(.success(poster))
        }.resume()
    }
}// End of Class
