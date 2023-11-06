//
//  ArticleListView.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//


import SwiftUI
import URLImage
import URLImageStore

struct ArticleListView: View {
    
    let article: Article
    
    var body: some View {
        
        VStack(alignment: .leading) {
          // Space Between
          //View()
            Text(article.title)
              .font(
                Font.custom("New York Small", size: 14)
                  .weight(.semibold)
              )
              .foregroundColor(.white)
              .frame(maxWidth: .infinity, alignment: .topLeading)
          Spacer()
            HStack(alignment: .center, spacing: 0) {
                Text(article.author ?? "N/A")
                  .font(
                    Font.custom("Nunito", size: 12)
                      .weight(.semibold)
                  )
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(formatDate(date:article.publishedAt))
                  .font(
                    Font.custom("Nunito", size: 12)
                      .weight(.semibold)
                  )
                  .multilineTextAlignment(.trailing)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .topTrailing)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 0)
            .frame(maxWidth: .infinity, alignment: .leading)
          // Alternating Views and Spacers
          //View()
        }
        .padding(8)
        .frame(maxWidth: .infinity, minHeight: 128, maxHeight: 128, alignment: .leading)
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
        .foregroundColor(Color.white)
       
      
        

        
//        ZStack {
//            if let imgurl = article.urlToImage,
//               let url = URL(string: imgurl){
//                URLImage(url,
//                         failure:{ error, _ in
//                    PlaceHolderImageView()
//                }, content: { image in
//                            image
//
//                                .scaledToFit()
//                                .clipped()
//                                .environment(\.urlImageOptions, URLImageOptions(loadOptions: [ .loadOnAppear, .cancelOnDisappear ]))
//                         })
//                    .frame(width: 350, height: 100)
//                    .cornerRadius(10)
//
//            }
//            else{
//                PlaceHolderImageView()
//            }
//
//
//            VStack(alignment: .leading, spacing: 10){
//
//                Text(article.title )
//                    .foregroundColor(.black)
//                    .font(.system(size: 12, weight: .semibold))
//
//
//            }.frame(width: 300, height: 100)
//                .padding()
//
//        }.frame(maxWidth: .infinity)
//            .frame(height: 100)
//            .foregroundColor(Color.white)
    }
}


struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}

func formatDate(date: Date) -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Customize the format as needed
       return formatter.string(from: date)
   }

