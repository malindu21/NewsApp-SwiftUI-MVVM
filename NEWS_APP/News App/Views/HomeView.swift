//
//  HomeView.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import SwiftUI
struct HomeView: View {
    
    @Environment(\.openURL) var openUrl
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    @State private var searchText: String = ""

      var filteredArticles: [Article] {
          if searchText.isEmpty {
              return viewModel.articles
          } else {
              return viewModel.articles.filter { article in
                  return article.title.localizedCaseInsensitiveContains(searchText)
              }
          }
      }
    
    var body: some View {
        ZStack{
            Color.white
            Group {
                switch viewModel.state {
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.getArticle)
                case .success:
                    VStack {
                        SearchView(searchText: $searchText,viewModel: viewModel)
                        
                        HStack{
                            HStack{
                                Text("Latest News")
                                  .font(
                                    Font.custom("New York Small", size: 18)
                                      .weight(.bold)
                                  )
                                  .foregroundColor(.black)
                                
                                Spacer()
                                
                            }.padding()
                            
                            Spacer()
                            HStack(alignment: .center, spacing: 16) {
                                Text("See All")
                                  .font(
                                    Font.custom("Nunito", size: 12)
                                      .weight(.semibold)
                                  )
                                  .foregroundColor(Color(red: 0, green: 0.5, blue: 1))
                                
                                Image("ic_combined_shape")
                                .frame(width: 9.85382, height: 12)
                        
                            
                           
                            }
                            .frame(width: 140, height: 12)
                            .padding(0)
                          
                           
                        }
                
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.articles, id: \.id) { item in
                                    ArticleView(article: item)
                                        .onTapGesture {
                                            load(url: item.url)
                                        }
                                }
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        ChipNavigationView(vm: viewModel)
                        
                        ScrollView(.vertical, showsIndicators: false){
                            LazyVStack {
                                ForEach(filteredArticles, id: \.id) { item in
                                    ArticleListView(article: item)
                                        .onTapGesture {
                                            load(url: item.url)
                                        }
                                        .background(Color.white) 
                                }
                                
                            }.padding()
                        }
                    }
                case .loading:
                    ProgressView()
                        .onAppear(perform: viewModel.getArticle)
                }
            }
        }
       
    }
    
    func load(url: String?){
        guard let link = url, let url = URL(string: link) else { return }
        openUrl(url)
    }
}

struct SearchView: View {
    @Binding var searchText: String
    @ObservedObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    var body: some View {
        HStack{
            Spacer()
            HStack(alignment: .center, spacing: 0) {
            TextField("Search", text: $searchText)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)

                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(width: 296, alignment: .leading)
            .background(Color.white)
            .cornerRadius(16)
            .overlay(
              RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 0.94, green: 0.94, blue: 0.98), lineWidth: 1)
            )
            Spacer()
            HStack(alignment: .center, spacing: 0) {
                
                Image("ic_notify")
                .frame(width: 13, height: 16)
            }.onTapGesture {
                viewModel.getArticle()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(
              LinearGradient(
                stops: [
                  Gradient.Stop(color: Color(red: 1, green: 0.23, blue: 0.27), location: 0.00),
                  Gradient.Stop(color: Color(red: 1, green: 0.5, blue: 0.53), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0, y: 0),
                endPoint: UnitPoint(x: 1.07, y: 1.65)
              )
            )
            .cornerRadius(16)
            Spacer()
        }

    }
}
