//
//  TweetRowView.swift
//  SlideOutMenu
//
//  Created by パクギョンソク on 2023/10/09.
//

import SwiftUI

struct TweetRowView: View {
    
    let image: String
    let username: String
    let fullname: String
    let caption: String
    let didLike: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(username)
                            .font(.subheadline).bold()
                        
                        Text("@\(username)")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Text("2w")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    // tweet caption
                    Text(caption)
                        .font(.subheadline)
                        // テキストの左寄せ
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.black)
                
                
            }
            
            HStack {
                Button {
                    
                } label: {
                     Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                     Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                
                Spacer()
                
                if didLike {
                    Button {
                    } label: {
                         Image(systemName: "heart.fill")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                } else {
                    Button {
                    } label: {
                         Image(systemName: "heart")
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                     Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }
            .padding()
            .foregroundColor(.primary)
            
            Divider()
        }
        .padding()
    }
}
