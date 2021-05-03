//
//  GetHotelPageResponseModel.swift
//  Rota
//
//  Created by Yasin Dalkilic on 1.05.2021.
//

import Foundation
import ObjectMapper

struct GetGuideMarketResponseModel : Mappable {
    var id : String?
    var text : String?
    var value : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        text <- map["Text"]
        value <- map["Value"]
    }

}

