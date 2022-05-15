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
        default:
            return ""
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.flickrApiBaseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Common Headers
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch self {
        case .photoSearch(let data):
            request = try URLEncoding.queryString.encode(request, with: data.dictionary)
        }
        return request
        
    }
    
}
