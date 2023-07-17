//
//  NewsView.swift
//  SpaceNews
//
//  Created by Richard Uzor on 17/07/2023.
//

import SwiftUI

struct NewsView: View {
    //view to design the news list
    
    @EnvironmentObject var data: SpaceApi
    @Environment(\.openURL) var openURL
    private var textWidth = 300.0
    var body: some View {
        List{
            ForEach(data.news){ news in
                NewsArticle(title: news.title, imageUrl: news.imageUrl, siteName: news.newsSite, summary: news.summary)
                    .onTapGesture {
                        openURL(URL(string: news.url)!)
                    }
            }
        }
        .refreshable {
            data.getData()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(SpaceApi())
    }
}
