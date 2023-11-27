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
                .frame(width: 380, height: 80)
                .foregroundColor(.blue1)
                .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
            RoundedRectangle(cornerRadius: 12)
                .padding(.horizontal)
                .frame(width: 380, height: 80)
                .foregroundColor(.white)
                .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
            configuration.content
                .frame(width: 380, height: 70)
        }
                        
    }
}
struct NavigationItem: Identifiable, Hashable {
    let id: Int
    let title: String
    let imageName: String
    let destination: AnyView
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NavigationItem, rhs: NavigationItem) -> Bool {
        lhs.id == rhs.id
    }
}

struct SearchView: View {
    let navigationItems: [NavigationItem] = [
            NavigationItem(id: 0, title: "핸들 왼쪽", imageName: "l.joystick.tilt.left", destination: AnyView(ListView1())),
            NavigationItem(id: 1, title: "핸들 오른쪽", imageName: "r.joystick.tilt.right", destination: AnyView(ListView2())),
            NavigationItem(id: 2, title: "센터페시아", imageName: "exclamationmark.brakesignal", destination: AnyView(ListView3())),
            NavigationItem(id: 3, title: "경고등", imageName: "exclamationmark.triangle", destination: AnyView(ListView4()))
        ]
    
    var body: some View {
        
            VStack{
                
                Text("기능 분류")
                    .foregroundColor(.black)
                    .padding(.top, 20)
                
                NavigationView {
                    ZStack{
                        Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
                        List {
                            
                            ForEach(navigationItems, id: \.id) { item in
                                
                                NavigationLink(destination: item.destination) {
                                    
                                    Label(item.title, systemImage: item.imageName)
                                        .padding(.vertical, 20)
                                    
                                }.foregroundColor(Color.black)
                                .task {
                                    if handleleftdetails.isEmpty {
                                        loadhandleleft()
                                    }
                                    if handlerightdetails.isEmpty {
                                        loadhandleright()
                                    }
                                    if centerfisciadetails.isEmpty {
                                        loadcenterfiscia()
                                    }
                                    if warninglightdetails.isEmpty {
                                        loadwarninglight()
                                    }
                                    
                                }
                                
                            }.listRowBackground(Color.white)
                        }
                        .scrollContentBackground(.hidden)
                        .padding(.top, 40)
                    }
                }
                
            
            
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
