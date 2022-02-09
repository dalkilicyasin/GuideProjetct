//
//  GetHotelsMobileResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 6.05.2021.
//

import Foundation
import ObjectMapper

struct GetHotelsMobileResponseModel : Mappable, Decodable, Encodable {
    var id : String?
    var guideHotel : Int?
    var value : Int?
    var text : String?
    var area : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        guideHotel <- map["GuideHotel"]
        value <- map["Value"]
        text <- map["Text"]
        area <- map["Area"]
    }

}

