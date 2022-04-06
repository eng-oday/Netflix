//
//  PopularMovies.swift
//  Netflix
//
//  Created by Oday Dieg on 22/03/2022.
//

import Foundation


struct Movies:Codable{
    
    let results:[Results]
    
}

struct Results:Codable{
    let id:Int
    let title:String?
    let original_language:String
    var original_title:String?
    let overview:String
    var poster_path:String?
    let vote_average:Float
    
}

