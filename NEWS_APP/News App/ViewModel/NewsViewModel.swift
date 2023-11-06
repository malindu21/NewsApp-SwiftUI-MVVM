//
//  NewsViewModel.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import Foundation
import Combine

protocol  NewsViewModel {
    func getArticle()
}

class NewsViewModelImpl: ObservableObject,NewsViewModel {
    
    private let service: NewsService
    
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    func getArticle() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getNews(category: ""))
            .sink{res in
                switch res{
                    
                case .finished:
                 
                    self.state = .success(content: self.articles)
            
                case .failure(let error):
                   
                    self.state = .failed(error: error)
                
                }
            } receiveValue: { response in
                self.articles = response.articles
                print("Response \(response)")
            }
        self.cancellables.insert(cancellable)
    }
    
    

}
