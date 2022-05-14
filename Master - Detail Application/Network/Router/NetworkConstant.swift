//
//  NetworkConstant.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//


import Foundation

struct NetworkConstants {
    
    static let apiKey = "56e76b73d922b98ec5dc571ca95eb139"
    
    static let flickrApiBaseURL = "https://api.flickr.com/services/rest/"
    
    static let searchURL = "?method=flickr.photos.search"
    
    static let moviesFileName = "movies"
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
 
}

enum ContentType: String {
    case json = "application/json"

}

