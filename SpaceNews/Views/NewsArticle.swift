//
//  NewsArticle.swift
//  SpaceNews
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI
import CachedAsyncImage

struct NewsArticle: View {
    
    //view to populate each item of the fetched news
    
    let title: String
    let imageUrl: String
    let siteName: String
    let summary: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(siteName)
                .foregroundColor(.blue)
                .italic()
            
            HStack(alignment: .center){
                //use the cachedasyncimage library to load and cache the news image from the url
                CachedAsyncImage(url: URL(string: imageUrl),
                                 transaction: Transaction(animation: .easeInOut)){ phase in
                    //set an animation to display the placeholder image
                    if let image = phase.image{
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .transition(.opacity)
                    }else{
                        HStack{
                            ProgressView()
                        }
                       
                    }
                }
            }
            Text(title)
                .font(.headline)
                .padding(8)
            
            Text(summary)
                .lineLimit(6)
                .font(.body)
                .padding(8)
        }
    }
}

struct NewsArticle_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticle(title: "XStrike", imageUrl: "...", siteName: "Devstrike", summary: "Devstrike, what an idea")
    }
}
