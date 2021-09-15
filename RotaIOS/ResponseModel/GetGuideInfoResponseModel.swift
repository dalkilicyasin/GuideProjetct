//
//  GetGuideInfoResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 20.05.2021.
//

import Foundation
import ObjectMapper

struct GetGuideInfoResponseModel : Mappable {
    var id : String?
    var gDE_ID : Int?
    var marketId : Int?
    var marketGroupId : Int?
    var areaId : Int?
    var multiMarket : String?
    var multiArea : String?
    var marketList : [Int]?
    var areaList : [Int]?
    var marketSelect : [MarketSelect]?
    var areaSelect : [AreaSelect]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        gDE_ID <- map["GDE_ID"]
        marketId <- map["MarketId"]
        marketGroupId <- map["MarketGroupId"]
        areaId <- map["AreaId"]
        multiMarket <- map["MultiMarket"]
        multiArea <- map["MultiArea"]
        marketList <- map["MarketList"]
        areaList <- map["AreaList"]
        marketSelect <- map["MarketSelect"]
        areaSelect <- map["AreaSelect"]
    }

}

struct AreaSelect : Mappable {
    var id : String?
    var value : Int?
    var text : String?
    var status : Int?
    var typeId : Int?
    var cmlValue : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        value <- map["Value"]
        text <- map["Text"]
        status <- map["Status"]
        typeId <- map["TypeId"]
        cmlValue <- map["CmlValue"]
    }

}

struct MarketSelect : Mappable {
    var id : String?
    var value : Int?
    var text : String?
    var status : Int?
    var typeId : Int?
    var cmlValue : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        value <- map["Value"]
        text <- map["Text"]
        status <- map["Status"]
        typeId <- map["TypeId"]
        cmlValue <- map["CmlValue"]
    }
}
