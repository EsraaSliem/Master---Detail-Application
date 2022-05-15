//
//  HomeServicesProtocol.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 15/05/2022.
//

import Foundation
protocol HomeServicesProtocol {
    func getPhotos(request:PhotoSearchRequest,
                         sucess: @escaping([Photo])->Void,
                         error: @escaping(Error)->Void)
    
    func loadMovies() -> [Movie]?

}
