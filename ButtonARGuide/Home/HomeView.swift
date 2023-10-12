//
//  HomeView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct HomeView: View {
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.white
            
        }
    var body: some View {
        
        NavigationView {
                    TabView {
                        ZStack{
                            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
                            ScrollViewReader { scrollView in
                                
                                Text("차량 정보 입력")
                                
                            }
                        }
                        .tabItem {
                            Image(systemName: "camera.circle.fill")
                                //.padding(.leading, 0)
                            Text("메인")
                          
                        }
                        ZStack{
                            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
                            ScrollViewReader { scrollView in
                                ScrollView {
                                    ZStack{
                                        SearchView().padding(.top, 70)
                                    }
                                }
                            }
                        }
                        .tabItem {
                            Image(systemName: "magnifyingglass.circle.fill")
                            Text("검색")
                        }
                        
        
                        ScrollViewReader { scrollView in
                            ScrollView {
                                ZStack{
                                    
                                    
                                    MyPageView()
                                }
                            }
                        }
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("마이페이지")
                        }
                        
                    }.toolbarBackground(.red, for: .tabBar)
                    .accentColor(.blue1)
            
                }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        HomeView()
    }
}

struct MainMy: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.pink1)
                .frame(width: 355, height: 206)
            VStack{
                HStack{
                    Text("내 정보")
                        .padding(.trailing, 240)
                        
                }
                Text("마이페이지")
                    .bold()
                    .padding()
                    .multilineTextAlignment(.leading)
                Text(currentUser?.email ?? "비로그인")
                Text(currentUserName)
                Spacer().frame(height:50)
            }
        }
    }

}
