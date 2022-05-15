//
//  Photos.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 15/05/2022.
//

import Foundation

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}
