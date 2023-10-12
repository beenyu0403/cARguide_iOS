//
//  HomeView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct HomeView: View {
    @State var selectedCar = ""
    var cars = ["차종을 선택하세요", "올 뉴 모닝 (2018)", "기타"]
    
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
                                    .padding(.bottom, 30.0)
                                Text("선택한 차종: \(selectedCar)")
                                    
                               
                                ZStack {
                                    RoundedRectangle(cornerRadius: 22)
                                        .frame(width: 300, height: 45)
                                        .foregroundColor(.blue1)
                                        .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
                                    RoundedRectangle(cornerRadius: 22)
                                        .frame(width: 302, height: 47)
                                        .foregroundColor(.clear)
                 
                                    RoundedRectangle(cornerRadius: 22)
                                        .frame(width: 300, height: 45)
                                        .foregroundColor(.white)
                                    
                                    Picker("차종을 선택하세요: ", selection: $selectedCar) {
                                        ForEach(cars, id: \.self) {
                                            Text($0)
                                        }
                                    }.pickerStyle(.menu)
                                    
                                }.padding(.bottom, 30.0)
                                
                                
                                
                                
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
