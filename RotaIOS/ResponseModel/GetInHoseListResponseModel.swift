//
//  PaxesListResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 11.05.2021.
//


import Foundation
import ObjectMapper

class GetInHoseListResponseModel : Mappable, Decodable, Encodable {
    var isTapped : Bool?
    var name : String?
    var ID : Int?
    var value : Int?
    var text : String?
    var resNo : String?
    var ageGroup : String?
    var marketId : Int?
    var mrkGrp : Int?
    var isSelected : Bool?
    var gender : String?
    var room : String?
    var birtDate : String?
    var checkIn : String?
    var checkOut : String?
    var phone : String?
    var passPort : String?
    var operatorName : String?

    required init?(map: Map) {
            
    }
        
    public init( text : String, ageGroup : String, gender : String, room : String, birtDate : String, name : String, checkOut : String, phone : String, operatorName : String ) {
        self.text = text
        self.ageGroup = ageGroup
        self.gender = gender
        self.room = room
        self.birtDate = birtDate
        self.name = name
        self.checkOut = checkOut
        self.phone = phone
        self.operatorName = operatorName
    }
    
    
    func mapping(map: Map) {
        name <- map["Name"]
        ID <- map["ID"]
        value <- map["Value"]
        text <- map["Text"]
        resNo <- map["resNo"]
        ageGroup <- map["AgeGroup"]
        marketId <- map["MarketId"]
        mrkGrp <- map["mrkGrp"]
        isSelected <- map["isSelected"]
        gender <- map["gender"]
        room <- map["room"]
        birtDate <- map["birtDate"]
        phone <- map["Phone"]
        checkIn <- map["CheckIn"]
        checkOut <- map["CheckOut"]
        passPort <- map["PassPort"]
        operatorName <- map["operatorName"]
    }
}
