//
//  PreviousHistoryView.swift
//  ButtonARGuide
//
//  Created by user on 11/18/23.
//

import SwiftUI

struct PreviousHistoryView: View {
    @State private var prelabelarray : [String] = prelabels
    @State private var predatearray : [String] = predates
    @State private var predetailarray : [String] = predetails
    
    // MARK: - 화면 구성
    var body: some View {
        ZStack{
            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
            if !prelabelarray.isEmpty {
                List {
                    ForEach(prelabelarray.indices, id: \.self) { e in
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(prelabelarray[e])
                                            .foregroundColor(Color.black)
                                        Spacer()
                                        Text(predatearray[e])
                                            .foregroundColor(Color.black)
                                        
                                        Text("삭제")
                                            .foregroundColor(.black)
                                            .onTapGesture {
                                                let DB = db.collection("PreviousHistory").document(currentUser?.email ?? "비로그인").collection("data")
                                                
                                                DB.document("\(predatearray[e])_\(prelabelarray[e])").delete() { err in
                                                  if let err = err {
                                                    print("Error removing document: \(err)")
                                                  } else {
                                                    print("Document successfully removed!")
                                                  }
                                                }
                                                prelabelarray.remove(at: e)
                                                predatearray.remove(at: e)
                                                predetailarray.remove(at:e)
                                            }
                                        
                                    }
//
                                    
                                    if prelabelarray[e] == "내/외기 공기 선택 버튼" {
                                        Image("내외기 공기 선택 버튼")
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 100,height: 100)
                                    }else{
                                        Image(prelabelarray[e])
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 100,height: 100)
                                    }
                                    
                                    Text("")
                                    
                                    Text(predetailarray[e])
                                        .foregroundColor(Color.black)
                                }
                        }.listRowBackground(Color(red: 141 / 255, green: 198 / 255, blue: 245 / 255))
                    
                    
                }.scrollContentBackground(.hidden)
                    
            }
        }.onAppear(){
            prelabelarray = prelabels
            predatearray = predates
            predetailarray = predetails
        }
    }
}

#Preview {
    PreviousHistoryView()
}
