//
//  Home.swift
//  SlideOutMenu
//
//  Created by パクギョンソク on 2023/09/10.
//

import SwiftUI

struct Home: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack {
            
            header
            
            ScrollView(.vertical, showsIndicators: false) {
                
                //mockDataはVStackで良い
                LazyVStack {
                    // 個人的に憧れる数人をMockデータに。。 (Those are the people I respect haha..)
                    TweetRowView(image: "person", username: "johnnyfpv", fullname: "Johnny Schaer", caption: "I'm the best FPV pilot!!", didLike: true)
                    TweetRowView(image: "elon", username: "elon", fullname: "Elon Musk", caption: "Now for Sale New Model3", didLike: true)
                    TweetRowView(image: "ethan", username: "ethanEE", fullname: "Ethan Ewing", caption: "My favorite skill is Cutback", didLike: false)
                    TweetRowView(image: "kelly", username: "kellyslater", fullname: "Kelly Slater", caption: "My @HBO 24/7 special is about to start:", didLike: true)
                    TweetRowView(image: "mkbhd", username: "mkbhd", fullname: "Marques Brownlee", caption: "Can You Trust Google?", didLike: true)
                }
            }
            
            Spacer()
        }
    }
}

extension Home {
    var header: some View {
        VStack(spacing: 0) {
            HStack {
                
                Button {
                    withAnimation {
                        showMenu.toggle()
                    }
                } label: {
                    Image("elon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }
                
                Spacer()
                
                NavigationLink {
                    Text("Timeline View")
                        .navigationTitle("TimeLine")
                } label: {
                    Image("Sparkles")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            Divider()
        }
        .overlay(
            Image("xlogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
