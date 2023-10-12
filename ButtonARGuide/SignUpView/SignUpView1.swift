//
//  SignUpView1.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

var isEmailDuplication = true
struct SignUpView1: View {
    @State var userName: String = ""
    @State var userEmail: String = ""
    @State var isEmailDuplicationLabel = false
    @State var isEmailDuplicationButton = false
    @EnvironmentObject var EmailviewModel: EmailViewModel
    
    enum Field: Hashable {
        case userName, userEmail
      }
    @FocusState private var focusField: Field?
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
                    Text("회원가입")
                        .foregroundColor(Color.black)
                }
            }
        }
    // MARK: - 화면 구성
    var body: some View {
        ZStack{
            Color(red: 250 / 255, green: 253 / 255, blue: 255 / 255).ignoresSafeArea()
            Image("carImage")
                .padding(.bottom, 430.0)
                .padding(.leading, 80.0)
            Image("paint1")
                .padding(.bottom, 330.0)
                .padding(.trailing, 224)
            
            VStack {
                Text("차량 내부 버튼 정보를")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 280, height: 30, alignment: .leading)
                Text("AR로 쉽게!")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(width: 280, height: 30, alignment: .leading)
                    .padding(.bottom, 60.0)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.blue1)
                        .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                    TextField("이름을 입력하세요.", text: $userName)
                        .focused($focusField, equals: .userName)
                        .disableAutocorrection(true) //자동 수정 비활성화
                        .textInputAutocapitalization(.never) //대문자 비활성화
                        .padding(.leading, 81)
                        .font(.system(size: 13, weight: .thin))
                    
                }.padding(.bottom, 30.0)
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.blue1)
                        .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 302, height: 47)
                        .foregroundColor(checkEmailCondition () ? .clear : Color.red)
                        
                    RoundedRectangle(cornerRadius: 22)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                        
                    TextField("이메일을 입력하세요.", text: $userEmail)
                        .onChange(of: userEmail){ _ in
                            isEmailDuplicationLabel = false
                            isEmailDuplicationButton = false
                            if EmailviewModel.emailDuplicationState(email: userEmail) {
                                isEmailDuplication = false
                            }else{
                                isEmailDuplication = true
                                print(isEmailDuplication)
                            }
                        }
                        .focused($focusField, equals: .userEmail)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding(.leading, 81)
                        .font(.system(size: 13, weight: .thin))
                        
                    
                    Button(action: {
                        self.isEmailDuplicationLabel = true
                        self.isEmailDuplicationButton=true
                        
                        print(isEmailDuplication)
                    }){
                        
                        if isEmailDuplication && isEmailDuplicationButton && !userEmail.isEmpty && checkEmailCondition() {
                            
                            Image("bluecheckbutton2")
                        }else {
                            Image("bluecheckbutton1")
                        
                        }
                                    
                    }.padding(.leading, 250)
                        
                    Text("이메일 형식을 확인해주세요.")
                        .font(.system(size: 11, weight: .regular))
                        .padding(.top, 80)
                        .frame(width: 250, height: 30, alignment: .leading)
                        .foregroundColor(checkEmailCondition () ? .clear : Color.red)
                    if isEmailDuplicationLabel && !isEmailDuplication && !userEmail.isEmpty {
                        
                        Text("이미 가입된 이메일입니다.")
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 80)
                            .frame(width: 250, height: 30, alignment: .leading)
                            .foregroundColor(Color.red)
                        
                    }
                    
                }.padding(.bottom, 140.0)
                    .onAppear (perform: UIApplication.shared.hideKeyboard)
                
                
                
                if checkButtonCondition () {
                    
                    NavigationLink(destination: SignUpView2()) {
                            ZStack {
                                
                                    RoundedRectangle(cornerRadius: 22)
                                        .frame(width: 320, height: 50)
                                        .foregroundColor(.buttonblue1)
                                        .shadow(color: .buttonblue1, radius: 10, x: 0, y: 7).opacity(0.4)
                                    RoundedRectangle(cornerRadius: 22)
                                        .frame(width: 320, height: 50)
                                        .foregroundColor(.buttonblue1)
                                    Text("다음").lineLimit(1)
                                        .font(.system(size: 17, weight: .medium))
                                        .frame(width: 320, height: 50, alignment: .center)
                                        .foregroundColor(Color.white)
                                
                            }
                        }
                }else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonblue1)
                            .shadow(color: .buttonblue1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 320, height: 50)
                            .foregroundColor(.buttonblue2)
                        Text("다음").lineLimit(1)
                            .font(.system(size: 17, weight: .medium))
                            .frame(width: 320, height: 50, alignment: .center)
                            .foregroundColor(Color.white)
                    }
                }
    
               
                
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    //MARK: - 함수 구현 공간
    // 이메일 형식 검사
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    func checkEmailCondition () -> Bool {
        if isValidEmail(id: userEmail) || userEmail.isEmpty {
            return true
        }
        return false
    }
    
    func checkButtonCondition () -> Bool {
        if !userName.isEmpty && !userEmail.isEmpty && isValidEmail(id: userEmail) {
            if isEmailDuplication && isEmailDuplicationButton {
                newUser.name = userName
                newUser.email = userEmail
                print("\(newUser.email)+생성 완료")
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
}

struct SwiftUpView1_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView1()
    }
}
