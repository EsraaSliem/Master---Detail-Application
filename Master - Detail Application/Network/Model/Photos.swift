//
//  Photos.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 15/05/2022.
//

import Foundation

struct Photos: Codable {
    let page: Int
    let pages: String
    let perpage: Int
    let total: String
    let photo: [Photo]
}
