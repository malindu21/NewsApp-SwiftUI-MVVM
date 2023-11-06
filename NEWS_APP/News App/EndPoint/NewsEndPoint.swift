//
//  EndPoint.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import Foundation


protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}


enum NewsAPI {
    case getNews(category: String)
    
    var category: String {
            switch self {
            case .getNews(let category):
                return category
            }
        }
}

var id = "ff6f2ea009a647a0a550a3ec3e3a4c18"


extension NewsAPI: APIBuilder {
    
    //req api
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: self.baseUrl.appendingPathComponent(self.path).absoluteString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "apiKey", value: "ff6f2ea009a647a0a550a3ec3e3a4c18")
        ]

        return URLRequest(url: (urlComponents?.url!)!)
    }
    // get data from api web
    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string:"https://newsapi.org")!
        }
    }
    
    //this is end of api what we need to access
    var path: String {
        return "/v2/top-headlines"
    }
    
    
}

