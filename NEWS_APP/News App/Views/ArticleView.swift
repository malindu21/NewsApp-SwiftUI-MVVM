//
//  ArticleView.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import SwiftUI
import URLImage
import URLImageStore

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        
        VStack(alignment: .leading) {
          // Space Between
          //View()
            Text(article.author ?? "N/A")
              .font(
                Font.custom("Nunito", size: 10)
                  .weight(.heavy)
              )
              .foregroundColor(.white)
              .frame(maxWidth: .infinity, alignment: .topLeading)
            Text(article.title)
              .font(
                Font.custom("New York Small", size: 16)
                  .weight(.bold)
              )
              .foregroundColor(.white)
              .frame(maxWidth: .infinity, alignment: .topLeading)
          Spacer()
            Text(article.articleDescription ?? "N/A")
              .font(Font.custom("Nunito", size: 10))
              .foregroundColor(.white)
              .frame(maxWidth: .infinity, alignment: .topLeading)
          // Alternating Views and Spacers
          //View()
        }
        .padding(.horizontal, 8)
        .padding(.top, 80)
        .padding(.bottom, 8)
        .frame(width: 321, alignment: .leading)
        .background(
          LinearGradient(
            stops: [
              Gradient.Stop(color: Color(red: 0.38, green: 0.38, blue: 0.38).opacity(0.35), location: 0.00),
              Gradient.Stop(color: .black, location: 1.00),
            ],
            startPoint: UnitPoint(x: 0.5, y: 0.5),
            endPoint: UnitPoint(x: 0.5, y: 1)
          )
        )
        .background(
            ZStack {
                if let imgurl = article.urlToImage, let url = URL(string: imgurl) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .environment(\.urlImageOptions, URLImageOptions(loadOptions: [.loadOnAppear, .cancelOnDisappear]))
                }
            }
        )
        .cornerRadius(8)
        
//        ZStack {
//            if let imgurl = article.urlToImage,
//               let url = URL(string: imgurl){
//                URLImage(url,
//                         failure:{ error, _ in
//                    PlaceHolderImageView()
//                }, content: { image in
//                            image
//                                .resizable()
//                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                                .environment(\.urlImageOptions, URLImageOptions(loadOptions: [ .loadOnAppear, .cancelOnDisappear ]))
//                         })
//                    .frame(width: 350, height: 300)
//                    .cornerRadius(10)
//
//            }
//            else{
//                PlaceHolderImageView()
//            }
//
//
//            VStack(alignment: .leading, spacing: 10){
//                Spacer(minLength: 220)
//                Text(article.title )
//                    .foregroundColor(.black)
//                    .font(.system(size: 18, weight: .semibold))
//                Text(article.articleDescription ?? "" )
//                    .foregroundColor(.gray)
//                    .font(.footnote)
//                Spacer()
//            }.frame(width: 300, height: 350)
//                .padding()
//
//        }.frame(maxWidth: .infinity)
//            .frame(height: 300)
    }
}

struct PlaceHolderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
    }
}
struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
