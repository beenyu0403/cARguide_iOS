//
//  EmailViewModel.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/12.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

var currentUser: Firebase.User? = Auth.auth().currentUser
var currentUserName = ""

var firestore: Firestore!
let db = Firestore.firestore()

struct User {
    var name: String
    var email: String
    var password: String
}
var newUser : User = User(name: "", email: "", password: "")

class EmailViewModel: ObservableObject {
   // var currentUser: Firebase.User? = Auth.auth().currentUser
    
    
    func emailAuthSignUp(email: String, userName: String, password: String) {
       
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

                if result != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    print("사용자 이메일: \(String(describing: result?.user.email))")
                    return
                }else{
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                        return
                    }
                }
            }
        
       
        }
    
    func emailDuplicationState(email: String) -> Bool {
        var result = false
                
                let userDB = db.collection("USER")
                // 입력한 이메일이 있는지 확인 쿼리
                let query = userDB.whereField("email", isEqualTo: email)
                query.getDocuments() { (qs, err) in
                    
                    if qs!.documents.isEmpty {
                        //print("데이터 중복 안 됨 가입 진행 가능")
                        result = true
                    } else {
                        print("데이터 중복 됨 가입 진행 불가")
                        isEmailDuplication = false
                        result = false
                    }
                }
                
                return result

    }
    
    func emailAuthSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
//            if user != nil{
//                print("login success")
//           }
//            else{
//                print("login fail")
//                print("Error: \(error!)")
//            }
            guard let strongSelf = self else { return }
        }
    }
    
    func nameState(currentemail: String) -> String{
        let userDB = db.collection("USER")
       var message = ""
        var searchlist = ""
        //userDB.document(currentUser?.email ?? "").addSnapshotListener { (qs, err) in
        userDB.document(currentemail).addSnapshotListener { (qs, err) in
                guard let document = qs else {
                    print("Error: \(err!)")
                    return
                }
            currentUserName = document.get("name") as? String ?? ""
            message = document.get("name") as? String ?? ""
            print("유저이름" + currentUserName)
           
        }
        return message
    }
//    func detailState(currentemail: String) {
//        let userDB = db.collection("PreviousHistory")
//        predates = []
//        prelabels = []
//        predetails = []
//        
//        
//        var m = ""
//        userDB.document(currentemail).collection("data").addSnapshotListener { (qs, err) in
//                guard let document = qs else {
//                    print("Error: \(err!)")
//                    return
//                }
//            //predates.append(document.get("date") as? String ?? "")
//            
//            var messages = [Message]()
//            qs?.documentChanges.forEach { change in
//                switch change.type {
//                case .added, .modified:
//                    do {
//                        if let message = try? change.document.data(as: Message.self) {
//                            predates.append(message.date)
//                            prelabels.append(message.label)
//                            predetails.append(message.detail)
//                            messages.append(message)
//                            
//                        }
//                    }catch {
//                        print("fail")
//                    }
//                default: break
//                }
//            }
//            premessages=messages
//           
//        }
//        
//        
//    }

    
}
struct Message: Codable {
    let date: String
    let detail: String
    let label: String
}
