//
//  MyPageView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        ZStack {
            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
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
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
