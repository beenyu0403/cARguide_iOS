//
//  SignUpView2.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//

import SwiftUI

struct SignUpView2: View {
    @State var userPw: String = ""
    @State var userPw2: String = ""
    @State var isActivePw = false
    @State var isActivePw2 = false
    @State var isActiveCheckButton2 = false
    @State var isActiveCheckButton3 = false
    @State var isPresented = false
    @EnvironmentObject var EmailviewModel: EmailViewModel
    
    enum Field: Hashable {
        case userPw, userPw2
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
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .semibold))
                        .frame(width: 280, height: 30, alignment: .leading)
                    Text("AR로 쉽게!")
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .semibold))
                        .frame(width: 280, height: 30, alignment: .leading)
                        .padding(.bottom, 60.0)
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 300, height: 45)
                            .foregroundColor(.blue1)
                            .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 302, height: 47)
                            .foregroundColor(checkPwCondition() ? .clear : Color.red)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 300, height: 45)
                            .foregroundColor(.white)
                        if isActivePw{
                            PlaceHolderField("비밀번호 입력 (8자리 이상, 영어+숫자)", font: .custom("", fixedSize: 11), color: .gray, text: $userPw)
                            //TextField("비밀번호 입력 (8자리 이상, 영어+숫자)", text: $userPw)
                                .focused($focusField, equals: .userPw)
                                .disableAutocorrection(true) //자동 수정 비활성화
                                .textInputAutocapitalization(.never)
                                .keyboardType(.alphabet)
                                .padding(.leading, 81)
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .thin))
                        }
                        else{
                            PlaceHolderField2("비밀번호 입력 (8자리 이상, 영어+숫자)", font: .custom("", fixedSize: 11), color: .gray, text: $userPw)
                            //SecureField("비밀번호 입력 (8자리 이상, 영어+숫자)", text: $userPw)
                                .focused($focusField, equals: .userPw)
                                .disableAutocorrection(true) //자동 수정 비활성화
                                .textInputAutocapitalization(.never)
                                .keyboardType(.alphabet)
                                .padding(.leading, 81)
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .thin))
                        }
                        
                        Button(action: {
                            self.isActivePw.toggle()
                            
                        }){
                            if isActivePw {
                                Image("blueEye2")
                            }else {
                                Image("grayEye1")
                            }
                            
                        }.padding(.leading, 250)
                        
                        Text("비밀번호 형식을 확인해주세요. (8자리 이상, 영어+숫자)")
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 80)
                            .frame(width: 250, height: 30, alignment: .leading)
                            .foregroundColor(checkPwCondition() ? .clear : Color.red)
                            
                        
                    }.padding(.bottom, 30.0)
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 300, height: 45)
                            .foregroundColor(.blue1)
                            .shadow(color: .blue1, radius: 10, x: 0, y: 7).opacity(0.4)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 302, height: 47)
                            .foregroundColor(checkPwSameCondition () ? .clear : Color.red)
                        RoundedRectangle(cornerRadius: 22)
                            .frame(width: 300, height: 45)
                            .foregroundColor(.white)
                        if isActivePw2 {
                            PlaceHolderField("비밀번호를 다시 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userPw2)
                            //TextField("비밀번호를 다시 입력하세요.", text: $userPw2)
                                .focused($focusField, equals: .userPw2)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding(.leading, 81)
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .thin))
                        }else {
                            PlaceHolderField2("비밀번호를 다시 입력하세요.", font: .custom("", fixedSize: 11), color: .gray, text: $userPw2)
                            //SecureField("비밀번호를 다시 입력하세요.", text: $userPw2)
                                .focused($focusField, equals: .userPw2)
                                .disableAutocorrection(true)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding(.leading, 81)
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .thin))
                        }
                        
                        Button(action: {
                            self.isActivePw2.toggle()
                            
                        }){
                            if isActivePw2 {
                                Image("blueEye2")
                            }else {
                                Image("grayEye1")
                            }
                            
                        }.padding(.leading, 250)
                        
                        Text("비밀번호가 일치하지 않습니다.")
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 80)
                            .frame(width: 250, height: 30, alignment: .leading)
                            .foregroundColor(checkPwSameCondition () ? .clear : Color.red)
                        
                        
                        Text("전체 동의하기")
                            .font(.system(size: 11, weight: .semibold))
                            .padding(.top, 168)
                            .padding(.leading, 30)
                            .frame(width: 250, height: 30, alignment: .leading)
                            .foregroundColor(.buttonblue1)
                        
                        Text("서비스 이용 약관")
                            .foregroundColor(.black)
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 213)
                            .padding(.leading, 30)
                            .frame(width: 250, height: 30, alignment: .leading)
                        Text("개인정보 수집 및 이용 동의")
                            .foregroundColor(.black)
                            .font(.system(size: 11, weight: .regular))
                            .padding(.top, 258)
                            .padding(.leading, 30)
                            .frame(width: 250, height: 30, alignment: .leading)
                        
                    }.padding(.bottom, 140.0)
                        .onAppear (perform: UIApplication.shared.hideKeyboard)
                    
                    
                    ZStack{
                        if nextButtonCondition ()  {
                            Button(action: {
                                self.isPresented.toggle()
                                db.collection("USER").document(newUser.email).setData([
                                    "email": newUser.email,
                                    "name": newUser.name,
                                    "password": newUser.password
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }
                                }
                                EmailviewModel.emailAuthSignUp(email: newUser.email, userName: newUser.name, password: newUser.password)
                            }){
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
                            }.fullScreenCover(isPresented: $isPresented){
                                SignUpView3()
                            }
                        }else {
                            ZStack {
                                RoundedRectangle(cornerRadius: 22)
                                    .frame(width: 320, height: 50)
                                    .foregroundColor(.blue2)
                                    .shadow(color: .blue2, radius: 10, x: 0, y: 7).opacity(0.4)
                                RoundedRectangle(cornerRadius: 22)
                                    .frame(width: 320, height: 50)
                                    .foregroundColor(.blue2)
                                Text("다음").lineLimit(1)
                                    .font(.system(size: 17, weight: .medium))
                                    .frame(width: 320, height: 50, alignment: .center)
                                    .foregroundColor(Color.white)
                            }
                        }
                        
                    }
                    
                }
                //MARK: - 서비스 동의 버튼 공간
                
                //첫번째 버튼
                Button(action: {
                    print("첫번째 동의 버튼 클릭함")
                    self.isActiveCheckButton2.toggle()
                    self.isActiveCheckButton3.toggle()
                    
                }){
                    if isActiveCheckButton2 && isActiveCheckButton3 {
                        Image("bluecheckbutton2")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }else {
                        Image("graycheckbutton1")
                            .resizable()
                            .frame(width: 22, height: 22)
                            
                    }
                }.padding(.top, 190)
                    .padding(.trailing, 230)
                //두번째 버튼
                Button(action: {
                    print("두번째 동의 버튼 클릭함")
                    self.isActiveCheckButton2.toggle()
                    
                }){
                    if isActiveCheckButton2 {
                        Image("bluecheckbutton2")
                            .resizable()
                            .frame(width: 22, height: 22)
                         
                    }else {
                        Image("graycheckbutton1")
                            .resizable()
                            .frame(width: 22, height: 22)
                                                
                    }
                }.padding(.top, 235)
                    .padding(.trailing, 230)
                
                //세번째 버튼
                Button(action: {
                    print("세번째 동의 버튼 클릭함")
                    self.isActiveCheckButton3.toggle()
                    
                }){
                    if isActiveCheckButton3 {
                        Image("bluecheckbutton2")
                            .resizable()
                            .frame(width: 22, height: 22)
                
                    }else {
                        Image("graycheckbutton1")
                            .resizable()
                            .frame(width: 22, height: 22)
                        
                            
                    }
                }.padding(.top, 280)
                .padding(.trailing, 230)
                
                //MARK: - 서비스 동의 더보기 버튼
                Button(action: {
                    print("서비스 이용 약관 보기 클릭함")
                    
                }){
                    Text("보기")
                        .font(.system(size: 11, weight: .regular))
                        .underline()
                        .foregroundColor(Color.gray)
                            
                }.padding(.top, 235)
                
                Button(action: {
                    print("개인정보 수집 및 이용 동의 보기 클릭함")
                    
                }){
                    Text("보기")
                        .font(.system(size: 11, weight: .regular))
                        .underline()
                        .foregroundColor(Color.gray)
                            
                }.padding(.top, 280)
                    .padding(.leading, 80)
                
            }
        
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        
        
    }
    //MARK: - 함수 구현 공간
    // 비밀번호 형식 검사
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
    
    func checkPwCondition () -> Bool {
        if isValidPassword(pwd: userPw) || userPw.isEmpty {
            return true
        }
        return false
    }
    
    func checkPwSameCondition () -> Bool {
        if userPw == userPw2 || userPw2.isEmpty {
            return true
        }
        return false
    }
    
    func nextButtonCondition () -> Bool {
        if checkPwCondition () && checkPwSameCondition () && !userPw.isEmpty && !userPw2.isEmpty && isActiveCheckButton2 && isActiveCheckButton3 {
            newUser.password = userPw
            print(newUser.password)
            
            
            return true
        }
        return false
    }
}

struct SignUpView2_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView2()
    }
    
}
