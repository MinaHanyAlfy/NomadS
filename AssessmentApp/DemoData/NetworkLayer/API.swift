//
//  API.swift
//  AssessmentApp
//
//  Created by John Doe on 2022-06-15.
//

import Foundation
enum API{
    case getDefault
  
}

extension API: EndPoint{
    var baseURL: String {
        return "https://run.mocky.io"
    }
    var urlSubFolder: String {
        return "/v3"
    }
    
    
    var queryItems: [URLQueryItem] {
        switch self {
        default:
            return []
        }
    }
    
    
    
    
    var method: HTTPMethod {
        switch self {
        default :
            return  .get
        }
    }
    
    
    var path: String {
        switch self {
        case .getDefault:
            return "4e23865c-b464-4259-83a3-061aaee400ba"
        }
    }
    
    var body: [String: Any]? {
        switch self{
        default:
            return nil
        }
    }
    
    
    

}


