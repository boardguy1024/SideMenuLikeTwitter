//
//  SideMenu.swift
//  SlideOutMenu
//
//  Created by パクギョンソク on 2023/09/10.
//

import SwiftUI

struct SideMenu: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            // Profile
            VStack(alignment: .leading, spacing: 10) {
                Image("Pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Text("iJustine")
                    .font(.title.bold())
                Text("@ijustine")
                    .font(.callout)
                
                HStack(spacing: 12) {
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            Text("Followers")
                        } icon: {
                            Text("1.2M")
                                .fontWeight(.bold)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            Text("following")
                        } icon: {
                            Text("189")
                                .fontWeight(.bold)
                        }
                    }
                }
                .foregroundColor(.primary)
                
            }
            .padding(.horizontal)
            .padding(.leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    VStack(alignment: .leading, spacing: 45) {
                        
                        TabButton(title: "Profile", image: "Profile")
                        
                        TabButton(title: "Lists", image: "Lists")
                        
                        TabButton(title: "Bookmarks", image: "Bookmarks")
                        
                        TabButton(title: "Moments", image: "Moments")
                        
                        TabButton(title: "Purchases", image: "Purchases")
                        
                        TabButton(title: "Topics", image: "Topics")
                        
                        TabButton(title: "Monetization", image: "Monetization")
                    }
                    .padding()
                    .padding(.leading)
                    .padding(.top, 35)
                    
                    Divider()
                    
                    TabButton(title: "Twitter Ads", image: "Ads")
                        .padding()
                        .padding(.leading)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Button("Setting And Privacy") {
                            
                        }
                        
                        Button("Help Center") {
                            
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .padding()
                    .padding(.leading)

                }
            }
            
            
            // Footer
            VStack(spacing: 0) {
                
                Divider()
                
                HStack {
                    Button {
                        
                    } label: {
                        Image("Light")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                        
                        Spacer()
                        
                        Image("QR")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 22, height: 22)
                    }
                }
                .padding([.horizontal, .top, .bottom])
            }
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .background(
            
            Color.primary
                .opacity(0.08)
                .ignoresSafeArea(.container, edges: .vertical)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    @ViewBuilder
    func TabButton(title: String, image: String) -> some View {
        
        NavigationLink {
            Text("\(title) View")
                .navigationTitle(title)
        } label: {
            HStack(spacing: 13) {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
