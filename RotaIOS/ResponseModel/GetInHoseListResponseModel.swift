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
    var id : String?
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

    required init?(map: Map) {
            
    }
        
    public init( text : String, ageGroup : String, gender : String, room : String, birtDate : String ) {
        self.text = text
        self.ageGroup = ageGroup
        self.gender = gender
        self.room = room
        self.birtDate = birtDate
    }
    
    
    func mapping(map: Map) {

        id <- map["$id"]
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
    }
}
