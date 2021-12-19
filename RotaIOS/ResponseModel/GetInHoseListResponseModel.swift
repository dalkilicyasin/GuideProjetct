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

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["$id"]
        value <- map["Value"]
        text <- map["Text"]
        resNo <- map["ResNo"]
        ageGroup <- map["AgeGroup"]
        marketId <- map["MarketId"]
        mrkGrp <- map["mrkGrp"]
    }
}
