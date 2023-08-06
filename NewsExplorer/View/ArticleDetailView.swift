//
//  ArticleDetailView.swift
//  NewsExplorer
//
//  Created by Arthur ? on 06.08.2023.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                if let imageUrl = URL(string: article.imageUrl ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .cornerRadius(5)
                    } placeholder: {
                        Image(systemName: "photo")
                            .frame(width: 150, height: 150)
                            .border(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                Text(article.title)
                    .font(.title.bold())
                
                Text(article.unwrappedDescription)
                
                VStack(alignment: .leading, spacing: 10) {
                    if let author = article.author {
                        Text("Article by: \(author)")
                    }
                    
                    if let sourceUrl = URL(string: article.sourceUrl) {
                        Link("Read more from \(article.source.name)", destination: sourceUrl)
                    }
                    
                    Text("Published on: \(article.publishedAt.formatted(date: .complete, time: .shortened))")
                }
                .font(.caption)
            }
            .ignoresSafeArea()
        }
        .padding(.horizontal, 20)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article.example)
    }
}
