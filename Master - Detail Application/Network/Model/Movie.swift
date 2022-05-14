//
//  Movie.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 15/05/2022.
//

import Foundation
struct Movie: Codable {
    let title: String
    let year: Int
    let cast: [String]
    let genres: [String]
    let rating: Int
}
