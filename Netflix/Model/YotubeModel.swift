//
//  YotubeModel.swift
//  Netflix
//
//  Created by Oday Dieg on 03/04/2022.
//

import Foundation



struct YotubeModel :Codable{
    
    let items:[YotubeResponse]
    
}

struct YotubeResponse:Codable {
    
    let id:videoElement
}
struct videoElement:Codable {
    
    let videoId:String
}
