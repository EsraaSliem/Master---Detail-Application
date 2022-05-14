//
//  HomeServices.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//


import Foundation
import Alamofire

class HomeServices: NSObject{
    
    //MARK:- getPhotos
    static func getPhotos(request:PhotoSearchRequest,
                          sucess: @escaping(PhotoSearchResponse)->Void,
                          error: @escaping(Error)->Void)
    {
        NetworkClient.performRequest(PhotoSearchResponse.self, router: APIRouter.photoSearch(request: request), success: {  (model) in
            sucess(model)
        }) {  (_error) in
            print(_error.localizedDescription)
            error(_error)
        }
        
    }
    
    func loadMovies() -> [Movie]? {
        if let url = Bundle.main.url(forResource: NetworkConstants.moviesFileName,
                                    withExtension: "json")
        {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesResponse.self, from: data)
                return jsonData.movies
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
