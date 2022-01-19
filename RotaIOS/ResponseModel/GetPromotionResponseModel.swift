//
//  GetPromotionResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 18.01.2022.
//

import Foundation
import ObjectMapper

struct GetPromotionResponseModel : Mappable {
    var id : String?
    var value : Int?
    var text : String?
    var status : Int?
    var typeId : Int?
    var cmlValue : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        value <- map["Value"]
        text <- map["Text"]
        status <- map["Status"]
        typeId <- map["TypeId"]
        cmlValue <- map["CmlValue"]
    }
}
