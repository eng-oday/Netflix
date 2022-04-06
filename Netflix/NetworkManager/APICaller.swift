//
//  APICaller.swift
//  Netflix
//
//  Created by Oday Dieg on 22/03/2022.
//

import Foundation
import UIKit


final class APiCaller{
    
    static let shared = APiCaller()
    
    
    func getPopular( completion: @escaping( Result<Movies,NetflixError>)->Void){
        
        guard let url = URL(string: API.baseURL+"movie/popular?api_key="+API.key) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil  else {
            completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let data    = try decoder.decode(Movies.self, from: data)
                completion(.success(data))
            }catch{
                completion(.failure(.invalidData))
            }
        }
        task.resume()
 
    }
    
    func downloadImageView(from StringURL: String , completion: @escaping (UIImage?)->Void){
        
        let imageURl = API.imageBase + "\(StringURL)"

        guard let url = URL(string: imageURl) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard  let data = data , error == nil  else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            completion(image)

        }
        task.resume()
    }
    

    func getTrendingMovies(completion: @escaping (Result<Movies,NetflixError>)->Void){
        
        guard let url = URL(string: API.baseURL + "trending/movie/day?api_key=\(API.key)") else{return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil  else {
            completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let decoder = JSONDecoder()
                let trending = try decoder.decode(Movies.self, from: data)
                completion(.success(trending))
            }catch{
               
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTrendingTV(completion: @escaping (Result<Movies,NetflixError>)->Void){
        
        guard let url = URL(string: API.baseURL + "trending/tv/day?api_key=\(API.key)") else{return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil  else {
            completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let decoder = JSONDecoder()
                let trending = try decoder.decode(Movies.self, from: data)
                completion(.success(trending))
            }catch{
               
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getUpcoming(completion: @escaping (Result<Movies,NetflixError>)->Void){
        
        guard let url = URL(string: API.baseURL + "movie/upcoming?api_key=\(API.key)") else{return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil  else {
            completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let decoder = JSONDecoder()
                let trending = try decoder.decode(Movies.self, from: data)
                completion(.success(trending))
            }catch{
               
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<Movies,NetflixError>)->Void){
        
        guard let url = URL(string: API.baseURL + "movie/top_rated?api_key=\(API.key)") else{return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil  else {
            completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let decoder = JSONDecoder()
                let trending = try decoder.decode(Movies.self, from: data)
                completion(.success(trending))
            }catch{
               
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    //(with: titleName + " trailer")
    func GetMovieTrailer(with query:String , completion: @escaping (Result<YotubeModel,NetflixError>)->Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(API.YotubeBaseURL)q=\(query)&key=\(API.YotubeKey)") else {
            return

        }
        print(url)

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil  else {
            completion(.failure(.unableToComplete))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            do{
                let decoder = JSONDecoder()
                let yotubeResponse = try decoder.decode(YotubeModel.self, from: data)
                completion(.success(yotubeResponse))
            }catch{

                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
        
        
    }

        
    
    
}
