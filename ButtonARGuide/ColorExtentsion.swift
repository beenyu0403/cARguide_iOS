//
//  ColorExtentsion.swift
//  ButtonARGuide
//
//  Created by user on 2023/10/13.
//
import SwiftUI


// ColorExtentsion.swift
extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}


//원하는 컬러 생성
extension Color {

   //static let yellow1 = Color(hex: "#FFDC48")
   static let pink1 = Color(hex: "#E65D92") //진한 보라색
   static let blue1 = Color(hex: "#8DC6F5") //진한 파란색
    static let blue2 = Color(hex: "#C0E0F9")
    static let buttonblue1 = Color(hex: "#6793F7") //버튼 진한 파란색
    static let buttonblue2 = Color(hex: "#A3BFFB") //버튼 연한 파란색
    static let pink2 = Color(hex: "#F1A6C3")
    static let backblue = Color(hex: "#4291DB")
   //static let backyellow = Color(hex: "#FFFDEB")
    //static let backpuple = Color(hex: "#FDF1FF")
}

//AR color tap test
extension UIColor {
    static func random() -> UIColor {
        UIColor(displayP3Red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1)
    }
}
