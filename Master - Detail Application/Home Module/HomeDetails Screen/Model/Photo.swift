//
//  Photo.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 15/05/2022.
//

import Foundation

struct Photo: Codable {
    let id, owner, secret: String
    let server: Server
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    var url: String {
        return "https://farm\(farm).static.flickr.com/\(server.value)/\(id)_\(secret).jpg"
    }
}
