//
//  PaxesListResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 11.05.2021.
//


import Foundation
import ObjectMapper

struct GetInHoseListResponseModel : Mappable {
    var id : String?
    var value : Int?
    var text : String?
    var resNo : String?
    var ageGroup : String?
    var marketId : Int?
    var mrkGrp : Int?
    var isSelected : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        value <- map["Value"]
        text <- map["Text"]
        resNo <- map["ResNo"]
        ageGroup <- map["AgeGroup"]
        marketId <- map["MarketId"]
        mrkGrp <- map["mrkGrp"]
    }

}
