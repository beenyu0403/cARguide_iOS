//
//  SearchView.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct blueGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {

        ZStack{
            configuration.content
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 12)
                .padding(.horizontal)
                .frame(width: 350, height: 80)
                .foregroundColor(.blue1)
                .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
            RoundedRectangle(cornerRadius: 12)
                .padding(.horizontal)
                .frame(width: 350, height: 80)
                .foregroundColor(.white)
                .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
            configuration.content
                .frame(width: 350, height: 70)
        }
                        
    }
}

struct SearchView: View {
    var body: some View {
        VStack{
            
            Text("기능 분류")
                .foregroundColor(.black)
                .padding(.top, 20)
            
            Button(action: {
                
                
            }){
                
                GroupBox {
                    Text("1번")
                        .foregroundColor(.black)
                }.groupBoxStyle(blueGroupBox())
                            
            }.padding(.top, 20)
    
            
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
