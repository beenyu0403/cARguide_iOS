//
//  HomeView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct HomeView: View {
    @State var tag:Int? = nil
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
                                    .padding(.top, 30.0)
                                    .padding(.bottom, 30.0)
                                    .foregroundColor(.black)
                                Text("선택한 차종: \(selectedCar)")
                                    .foregroundColor(.black)
                                    .padding(.bottom, 80.0)
                                    
                               
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
                                    
                                }.padding(.bottom, 250.0)
                                
                                ZStack{
                                    NavigationLink(destination: ARSceneView(), tag: 1, selection: self.$tag ) {
                                              EmptyView()
                                            }
                                    
                                    Button(action: {
                                        self.tag = 1
                                    }){
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 22)
                                                .frame(width: 320, height: 50)
                                                .foregroundColor(.buttonblue1)
                                                .shadow(color: .buttonblue1, radius: 10, x: 0, y: 7).opacity(0.4)
                                            RoundedRectangle(cornerRadius: 22)
                                                .frame(width: 320, height: 50)
                                                .foregroundColor(.buttonblue1)
                                            Text("AR 화면으로 이동하기").lineLimit(1)
                                                .font(.system(size: 17, weight: .medium))
                                                .frame(width: 320, height: 50, alignment: .center)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                   
                                }
                                
                                
                            }
                        }
                        .tabItem {
                            Image(systemName: "camera.circle.fill")
                                
                            Text("메인")
                          
                        }
                        ZStack{
                            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()

                            SearchView().padding(.top, 10)
                        }
                        .tabItem {
                            Image(systemName: "magnifyingglass.circle.fill")
                            Text("검색")
                        }
                        
                        ZStack{
                            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
                            ScrollViewReader { scrollView in
                                ScrollView {
                                    ZStack{
                                        
                                        
                                        MyPageView()
                                    }
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


