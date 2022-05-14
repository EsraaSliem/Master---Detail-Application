//
//  NetworkClient.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 15/05/2022.
//

import Foundation
import Alamofire

struct NetworkClient {

    typealias onSuccess<T> = ((T) -> ())
    typealias onFailure = ( (_ error: Error) -> ())
   
    // object parameter is added here so the T generic param can infer the type
    // All objects must conform to "Decodable" protocol
    
    static func performRequest<T>(_ object: T.Type, router: APIRouter, success: @escaping onSuccess<T>, failure: @escaping onFailure) where T: Decodable{
            AF.request(router).responseJSON { (response) in
                do {
                    print("responseresponse :\(response)")
                    print("router.path :\(router.path)")
                    let Lists = try JSONDecoder().decode(object.self, from: response.data!)
                    success(Lists)
                } catch let error{
                    failure(error)
                }
        }
    }
}
