//
//  Router.swift
//  Master - Detail Application
//
//  Created by Esraa Sliem on 14/05/2022.
//


import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case photoSearch(request: PhotoSearchRequest)
    
    var method: HTTPMethod {
        switch self {
       
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .photoSearch(_):
            return NetworkConstants.flickrApiBaseURL
        }
    }
    
    var parameters: Parameters? {
        switch self {
       
        case .photoSearch(let request):
            do {
                let dict = try? request.asDictionary()
                print(dict)
                return dict
            } catch {
                print("catch")
                return nil
            }
       
        }
    }
    // encoding, either URL (normal url query) or a JSON body..
    var encoding: ParameterEncoding {
        switch self {
            
        default:
            return JSONEncoding.default
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.flickrApiBaseURL.asURL().appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Common Headers
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let parameters = parameters {
            return try encoding.encode(request, with: parameters)
        }
        
        return request
    }
    
}
