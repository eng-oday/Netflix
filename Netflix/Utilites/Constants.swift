//
//  File.swift
//  Netflix
//
//  Created by Oday Dieg on 20/03/2022.
//

import Foundation
import UIKit

enum TabBar {
    
    static let home         = "Home"
    static let search       = "Search"
    static let comingSoon   = "Coming Soon"
    static let downloads    = "Downloads"
    
}
enum Image {
    static let playBtn      = "play.circle"
}
enum NotificationCenterNames{
    
    static let ComingSoonArrayOfData = "Netflix.ComingSoon"
    
}

enum TabBarImage {
    
    static let home         = UIImage(systemName: "house.fill")
    static let search       = UIImage(systemName: "magnifyingglass")
    static let comingsoon   = UIImage(systemName: "play.tv.fill")
    static let downloads    = UIImage(systemName: "arrow.down.circle.fill")
}
enum navigationBarImage {
    
    static let profile  = UIImage(systemName: "person")
    static let play     = UIImage(systemName: "play.rectangle")
    static let logo     = UIImage(named: "netflixLogo")
}

enum API {
    
    static let key              = "e95fbde08b882da788941774c3063a06"
    static let baseURL          = "https://api.themoviedb.org/3/"
    static let imageBase        = "https://image.tmdb.org/t/p/w500/"
    static let YotubeKey        = "AIzaSyDcK_wr637ya2jF7rF4yIigh8deGZRLWb8"
    static let YotubeBaseURL    = "https://www.googleapis.com/youtube/v3/search?"
    
}


enum NetflixError: String,Error{
    
    case unableToComplete   = "Please check your internet connection"
    case invalidResponse    = "Invalid response from the server , Please try again"
    case invalidData        = "The data received from the server was invalid , Please try again"
    case unableToFavorite   = "There was an error favoriting this user . Please Try again. "
    case alreadyInFavorites = "You've already favorited this user. You must REALLY Like them!"
}

enum HeadersTittle {
    
    static let MainPoster           = ""
    static let trendingMovies       = "Trending Movies"
    static let popular              = "Popular"
    static let trendingTV           = "Trending TV"
    static let comingSoon           = "Coming Soon"
    static let topRated             = "Top Rated"
}

