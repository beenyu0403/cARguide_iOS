//
//  ListView4.swift
//  ButtonARGuide
//
//  Created by user on 11/18/23.
//

import SwiftUI

struct ListView4: View {
    @State private var sheetTodo: Detaillabel2?
    @State private var buttonname: String = ""
    @State private var isshow: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // MARK: - 뒤로가기 구성
    var backButton : some View {  // <--커스텀 버튼
            Button{
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "chevron.left") // 화살표 Image
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.black)
                    
                }
            }
        }
    var body: some View {
        // MARK: - 화면 구성
        ZStack{
            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
            
            VStack{
                
                List {
                    Section(header: Text("경고등")) {
                        ForEach(warninglightdetails) { d in
                            HStack {
                                Text(d.text)
                                Spacer()
                                if !isshow  {
                                    Button(action: {
                                        sheetTodo = d
                                        buttonname = d.name
                                    }){
                                        Text("+")
                                    }
                                }else{
                                    Text("+")
                                }
                            }
                            .foregroundColor(Color.black)
                            .padding(.vertical, 20)
                        }
                        .listRowBackground(Color.white)
                    }.foregroundColor(Color.black)
                    
                    
                }
                .listStyle(SidebarListStyle())
                .scrollContentBackground(.hidden)
                .sheet(item: $sheetTodo) { todo in
                    VStack {
                        Text("상세 설명")
//                        AsyncImage(url: URL(string: "\(todo.img)")) { image in
//                            image
//                                .resizable()
//                                .clipShape(Circle())
//                                .frame(width: 100,height: 100)
//                        }placeholder: {
//                            ProgressView()
//                        }.padding(.bottom, 50)
                        Image("\(todo.text)")
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100,height: 100)
                            .padding(.bottom, 50)
                        Text("Task: \(todo.text)")
                        Text("Number: \(todo.num)")
                        Text("Detail: \(todo.detail)")
                            .multilineTextAlignment(.leading)
                            .frame(width: 300)
                    }.onDisappear() {
                        isshow = false
                    }.onAppear() {
                        isshow = true
                    }
                }
                
            }
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
    }
}

#Preview {
    ListView4()
        .task {
        loadwarninglight()
        }
}
