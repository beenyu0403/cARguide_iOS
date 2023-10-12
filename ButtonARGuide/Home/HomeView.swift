//
//  HomeView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
            Text("홈화면")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
