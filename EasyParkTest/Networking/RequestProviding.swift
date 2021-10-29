//
//  RequestProviding.swift
//  EasyParkTest
//
//  Created by Vitalii Kizlov on 29.10.2021.
//

import Foundation

protocol RequestProviding {
    func urlRequest() -> URLRequest
}

enum CitiesListEndpoint: RequestProviding {
    case citiesList
    
    private static let baseURLString = "pgroute-staging.easyparksystem.net"
    
    private enum HTTPMethod {
        case get
        case post
        case put
        case delete
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .citiesList:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .citiesList:
            return "/cities"
        }
    }
    
    func urlRequest() -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = CitiesListEndpoint.baseURLString
        components.path = path
        
        guard let url = components.url else {
            preconditionFailure("Can't create URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        print("Request ----", request)
        return request
    }
}
