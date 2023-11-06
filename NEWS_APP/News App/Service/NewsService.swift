//
//  NewsService.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import Foundation
import Combine

protocol NewsService {

    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>
}

struct  NewsServiceImpl: NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>{
        let dataKu = endpoint.urlRequest
        return URLSession
            .shared 
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{
                _ in APIError.unknown
            }
            .flatMap{ data, response -> AnyPublisher<NewsResponse,APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                

                if(200...299).contains(response.statusCode){
                  
                    let jsonDcoder = JSONDecoder()
                    jsonDcoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: NewsResponse.self , decoder: jsonDcoder)
                        .mapError{
                            _ in APIError.decodingError
                        }
                        .eraseToAnyPublisher()
                }
                else{
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
                
            }
            .eraseToAnyPublisher()//
    }
}
