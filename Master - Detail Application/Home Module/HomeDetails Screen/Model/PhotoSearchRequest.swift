//
//  PhotoSearchRequest.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//

import Foundation

struct PhotoSearchRequest: Codable {
    let title: String
    let page: Int
    let perPage: Int
    let nojsoncallback: Int = 1
    let format: String = "json"
    let requestKey: String
    
    enum CodingKeys: String, CodingKey {
        case title = "text"
        case perPage = "per_page"
        case requestKey = "api_key"
        case nojsoncallback
        case format, page
    }
}
