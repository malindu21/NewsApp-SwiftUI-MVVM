//
//  NavHostView.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//
import SwiftUI

import URLImage
import URLImageStore

struct NavHostView: View {
    @State private var selectedTab = 0

    var body: some View {
        
        
        VStack {
            TabContent(selectedTab: $selectedTab)
        }
        .onAppear {
            UITabBar.appearance().barTintColor = .white // Background color
            UITabBar.appearance().tintColor = .red // Selected item color
        }
        .background(Color.white) // Set the background color to white
        .overlay(
            VStack {
                ZStack(alignment: .bottom) {
                    
                    GeometryReader { reader in
                        Color.white
                            .frame(height: reader.safeAreaInsets.bottom, alignment: .bottom) // Change .top to .bottom
                            .ignoresSafeArea()
                    }

                    HStack {
                        TabBarButton(imageName: "house", text: "Home", tag: 0, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(imageName: "star", text: "Favorites", tag: 1, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(imageName: "person", text: "Profile", tag: 2, selectedTab: $selectedTab)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .frame(width: 289, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(32)
                    .shadow(color: Color(red: 0.55, green: 0.55, blue: 0.55).opacity(0.15), radius: 2, x: -2, y: 4)
                }
              
            }
        )
        .frame(maxHeight: .infinity) // Expand to the maximum height
    }
}


struct TabContent: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        TabView(selection: $selectedTab) {
 
            HomeView()
                .tag(0)
            
            HomeView()
                .tag(1)
            
            HomeView()
                .tag(2)
        }.ignoresSafeArea(.keyboard, edges: .bottom)
            .onAppear() {
                                   
          
                    let appearance = UITabBarAppearance()
                    appearance.configureWithTransparentBackground() // <- HERE
                    appearance.stackedLayoutAppearance.normal.iconColor = .white
                    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

                    appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.accentColor)
                    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color.accentColor)]

                    UITabBar.appearance().standardAppearance = appearance
                
                                       }
    }
}

struct TabBarButton: View {
    let imageName: String
    let text: String
    let tag: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = tag
        }) {
            VStack(spacing: 5) {
                Image(systemName: imageName)
                Text(text)
                    .font(.caption)
            }
            .foregroundColor(selectedTab == tag ? .red : .primary)
        }
    }
}


@main
struct News_AppApp: App {
    var body: some Scene {
        let urlImageService = URLImageService(fileStore: URLImageFileStore(),
                                              inMemoryStore: URLImageInMemoryStore())
        return WindowGroup {
            LoginView()
                .environment(\.urlImageService, urlImageService)
        }
    }
}
