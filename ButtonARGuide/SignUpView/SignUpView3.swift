//
//  SignUpView3.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct SignUpView3: View {
    @State var isPresented: Bool = false
    var body: some View {
        ZStack {
            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
            VStack {
                Text("환영합니다!")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 280, height: 30, alignment: .leading)
                    .padding(.top, 30)
                Image("Logo")
                    .resizable()
                    .frame(width: 350, height: 200)
                    .padding(.bottom, 40.0)
                    .padding(.leading, 0.0)
                Text("와 함께 해요")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 280, height: 30, alignment: .leading)
                    .padding(.bottom, 60.0)
                
                // MARK: - 로그인 버튼
                Button(action: {
                    self.isPresented.toggle()
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonblue1)
                            .shadow(color: .buttonblue1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonblue1)
                        Text("로그인 하기").lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                }.padding(.top, 100)
                    .fullScreenCover(isPresented: $isPresented){
                    ContentView()
                }
                
                
                
            }
        }
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SignUpView3_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView3()
    }
}
