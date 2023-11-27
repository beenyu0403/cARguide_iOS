//
//  MyPageView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var EmailviewModel: EmailViewModel
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
                            //Text(currentUser?.email ?? "비로그인")
                            Text(currentUserName)
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
//                                    EmailviewModel.detailState(currentemail: currentUser?.email ?? "비로그인")
                                    
                                }
                        }
                        .padding(.bottom, 360)
                        
                    }
                    
                }
                
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {

        MyPageView()
        
    }
}
