//
//  MyPageView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var EmailviewModel: EmailViewModel
    
    // MARK: - 화면 구성
    var body: some View {
        NavigationStack() {
            ZStack {
                Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
                VStack{
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.blue1)
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
                            Text(currentUserName)
                            Text(currentUser?.email ?? "비로그인")
                            Spacer().frame(height:50)
                        }
                        
                    }.padding(.top, 40)
                    
                    ZStack {
                        Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
                        NavigationLink(destination: PreviousHistoryView()) {
                            GroupBox {
                                Text("AR 화면 검색 기록")
                                    .foregroundColor(.black)
                            }.groupBoxStyle(blueGroupBox())
                                .task {
                                    EmailviewModel.detailState(currentemail: currentUser?.email ?? "비로그인")
                                    
                                }
                        }
                        .padding(.bottom, 320)
                        GeometryReader { geo in
                            let w = geo.size.width
                            let h = 250
                            
                            TabView {
                                ForEach(1..<5) { index in
                                    Image("공지\(index)")
                                        .resizable()
                                        .frame(width: w, height: CGFloat(h))
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(width: w, height: CGFloat(h))
                            .padding(.top, 160)
                            .onAppear(){
                                setupAppearance()
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.buttonblue1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(.buttonblue1).withAlphaComponent(0.2)
      }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {

        MyPageView()
        
    }
}
