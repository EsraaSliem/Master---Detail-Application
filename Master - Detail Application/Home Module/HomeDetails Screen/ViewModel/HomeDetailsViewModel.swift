//
//  HomeDetailsViewModel.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//

import Foundation
class HomeDetailsViewModel: NSObject {
    //MARK:- Properties
    let movie: Movie
    var photos: [Photo] = [] {
        didSet {
            reloadMoviesCollectionsViewClosure?()
        }
    }
    var genres: String {
        return movie.genres.joined(separator:", ")
    }
    var cast: String {
        return movie.cast.joined(separator:", ")
    }
    let services: HomeServicesProtocol
    var reloadMoviesCollectionsViewClosure: (()->())?
    
    //MARK:- Init
    init(services: HomeServicesProtocol = HomeServices(), movie: Movie) {
        self.services = services
        self.movie = movie
    }
    
    //MARK:- Data Presentation
    // handling cells and tableViewData from loaded data
    func getPhotsCount() -> Int {
        return photos.count
    }
    
    func getPhotoINdex(index: Int) -> String {
        return photos[index].url
    }
    
    
    //MARK:- Load Data
    // get movies Photos from api
    func getMoviePhotos() {
        let request = createRequest()
        services.getPhotos(request: request, sucess: {[weak self] photos in
            self?.photos = photos
        }, error: { error in
            // TODO: -handling error
            print(error)
        })
    }
    
    // grouping and categories data by year
    func createRequest() -> PhotoSearchRequest {
        return PhotoSearchRequest(title: movie.title, page: 1, perPage: 10)
    }
}
