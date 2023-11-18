//
//  ButtonListModel.swift
//  ButtonARGuide
//
//  Created by user on 11/18/23.
//
import Foundation
import SwiftUI

extension Encodable {
    
    var toDictionary : [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return nil }
        return dictionary
    }
}

struct Detaillabel: Identifiable {
  let id = UUID()
  var name: String
  var text: String
  var num: Int
    var img: String
}

struct ListInfo: Codable {
    var handleleft, handleright, centerfiscia, warninglight: [Meta]
}

struct Meta: Codable {
    var name, text: String
    var num: Int
    var img: String
}
var handleleftdetails : [Detaillabel] = []
var handlerightdetails : [Detaillabel] = []
var centerfisciadetails : [Detaillabel] = []
var warninglightdetails : [Detaillabel] = []

func loadhandleleft() {
    let data: Data
    
    if let filePath = Bundle.main.url(forResource: "buttondetaildata", withExtension: "json") {
        do {
            data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let listInfo = try decoder.decode(ListInfo.self, from: data)
            let listList = listInfo.handleleft
            for i in listList {
                handleleftdetails.append(Detaillabel(name: i.name, text: i.text, num: i.num, img: i.img))
                print(i.text)
            }
        } catch {
            print("Can not load Json file.")
        }
    }
}
func loadhandleright() {
    let data: Data
    
    if let filePath = Bundle.main.url(forResource: "buttondetaildata", withExtension: "json") {
        do {
            data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let listInfo = try decoder.decode(ListInfo.self, from: data)
            let listList = listInfo.handleright
            for i in listList {
                handlerightdetails.append(Detaillabel(name: i.name, text: i.text, num: i.num, img: i.img))
                print(i.text)
            }
        } catch {
            print("Can not load Json file.")
        }
    }
}
func loadcenterfiscia() {
    let data: Data
    
    if let filePath = Bundle.main.url(forResource: "buttondetaildata", withExtension: "json") {
        do {
            data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let listInfo = try decoder.decode(ListInfo.self, from: data)
            let listList = listInfo.centerfiscia
            for i in listList {
                centerfisciadetails.append(Detaillabel(name: i.name, text: i.text, num: i.num, img: i.img))
                print(i.text)
            }
        } catch {
            print("Can not load Json file.")
        }
    }
}
func loadwarninglight() {
    let data: Data
    
    if let filePath = Bundle.main.url(forResource: "buttondetaildata", withExtension: "json") {
        do {
            data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let listInfo = try decoder.decode(ListInfo.self, from: data)
            let listList = listInfo.warninglight
            for i in listList {
                warninglightdetails.append(Detaillabel(name: i.name, text: i.text, num: i.num, img: i.img))
                print(i.text)
            }
        } catch {
            print("Can not load Json file.")
        }
    }
}

