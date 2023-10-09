//
//  BaseView.swift
//  SlideOutMenu
//
//  Created by パクギョンソク on 2023/09/09.
//

import SwiftUI

struct BaseView: View {
    
    @State var showMenu: Bool = false
    @State var currentTab = "Home"
    
    // Offset for Both Drag Gestures and showing Menu.
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    @GestureState var gestureOffset: CGFloat = 0
    
    private let sideBarWidth = UIScreen.main.bounds.width - 90

    init() {
        // tabBarを隠す
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        
        let sideBarWidth = getRect().width - 90
        
        NavigationView {
            
            HStack(spacing: 0) {
                SideMenu(showMenu: $showMenu)
                
                // Main Tab View
                VStack(spacing: 0) {
                    
                    TabView(selection: $currentTab) {
                        Home(showMenu: $showMenu)
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Home")
                        
                        Text("Search")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Search")
                        
                        Text("Notifications")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Notifications")
                        
                        Text("Message")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarHidden(true)
                            .tag("Message")
                    }
                    
                    VStack(spacing: 0) {
                        
                        Divider()
                        
                        // CustomTabBar
                        HStack(spacing: 0) {
                            TabButton(image: "Home")
                            
                            TabButton(image: "Search")
                            
                            TabButton(image: "Notifications")
                            
                            TabButton(image: "Message")
                        }
                        .padding(.top, 15)
                        .background(Color.black.opacity(0.03)) // 確認のため背景をかける
                    }
                  
                }
                .frame(width: getRect().width)
                .overlay(
                    Rectangle()
                        .fill(
                            // offset: 300 / 300 = 1
                            // 1 / 5 = 0.2
                            Color.primary.opacity( (offset / sideBarWidth) / 5.0 )
                        )
                        .ignoresSafeArea(.container, edges: .all)
                        .onTapGesture {
                            showMenu.toggle()
                        }
                        
                )
            }
            // maxWidth : sideBarWidth + screenWidth
            .frame(width: sideBarWidth + getRect().width)
            .offset(x: -sideBarWidth / 2)
            .offset(x: offset)
            .gesture(
                DragGesture()
                    .updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded(onEnd(value:))
            )
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .animation(.linear(duration: 0.15), value: offset == 0)
        .onChange(of: showMenu) { newValue in
            // ここで offsetを使う理由としては、offsetが変わるにつれて背景の黒半透明をAnimationさせるため
            if showMenu && offset == 0 {
                offset = sideBarWidth
                lastStoredOffset = offset
            }
            
            if !showMenu && offset == sideBarWidth {
                offset = 0
                lastStoredOffset = 0
            }
        }
        .onChange(of: gestureOffset) { newValue in
         
            if gestureOffset != 0 {
                                
                // Draggingしたwidthが SideBarWidth以内の場合
                if gestureOffset + lastStoredOffset < sideBarWidth && (gestureOffset + lastStoredOffset) > 0 {
                    
                    offset = lastStoredOffset + gestureOffset
                    
                } else {
                    // sideMenuWidth範囲外の場合
                    if gestureOffset + lastStoredOffset < 0 {
                        // Draggingがdeviceの左端を超えた場合には 0で sideMenuを完全にしまう
                        offset = 0
                    }
                }
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
                
        withAnimation(.spring(duration: 0.15)) {
            
            if value.translation.width > 0 {
                // Dragging>>>
                
                // 指を離した位置が sideBarWidthの半分を超えた場合
                // (注意: valueは draggingにより 0から始まる
                if value.translation.width > sideBarWidth / 2 {

                    offset = sideBarWidth
                    lastStoredOffset = sideBarWidth
                    showMenu = true
                } else {
                    
                    // sideMenuが開いている状態で右端の方にdraggingした際には誤って閉じないように回避させる
                    if value.translation.width > sideBarWidth && showMenu {
                        offset = 0
                        showMenu = false
                    } else {
                        // velocityによる判定
                        // 指を離した位置が半分以下でも Dragging加速度が早ければ SideMenuを開く
                        if value.velocity.width > 800 {
                            offset = sideBarWidth
                            showMenu = true
                        } else if showMenu == false {
                            // showSideMenu == false状態で、指を離した位置が半分以下なら 元に戻す
                            offset = 0
                            showMenu = false
                        }
                    }
                }
            } else {
                // <<<Dragging
                
                if -value.translation.width > sideBarWidth / 2 {
                    offset = 0
                    showMenu = false
                } else {
                    
                    // sideMenuが閉じている状態で左の方にDraggingする場合には
                    // この処理を回避させる
                    guard showMenu else {
                        return }
                    
                    // 指を離した位置が半分以下でも <<<左のDragging加速度が早ければ sideMenuを閉じる
                    if -value.velocity.width > 800 {
                        offset = 0
                        showMenu = false
                    } else {
                        offset = sideBarWidth
                        showMenu = true
                    }
                                                   
                }
            }
        }
        
        lastStoredOffset = offset
    }
    
    @ViewBuilder
    func TabButton(image: String) -> some View {
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 23, height: 23)
                .foregroundColor(currentTab == image ? .primary : .gray)
                .frame(maxWidth: .infinity)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
