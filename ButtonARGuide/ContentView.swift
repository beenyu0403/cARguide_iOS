//
//  ContentView.swift
//  ButtonARGuide
//
//  Created by user on 2023/09/29.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
            // MARK: - 로고
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, 90.0)
                    .frame(width: 350, height: 200)
                
                // MARK: - 버튼 구성
                NavigationLink(destination: SignUpView1()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.blue1)
                            .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.blue1)
                        Text("회원가입 하기").lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                }.padding(.bottom, 30.0)
                
                
                
                NavigationLink(destination: SignInView1()) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonblue1)
                            .shadow(color: .buttonblue1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonblue1)
                        Text("로그인 하기")
                            .lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                        
                    }
                }
                
            }.navigationBarHidden(true)
            
                .padding()
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
