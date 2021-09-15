//
//  GuideGetSelectListResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 14.09.2021.
//

import Foundation
import ObjectMapper

struct GuideGetSelectListResponseModel : Mappable {
    var id : String?
    var value : Int?
    var text : String?
    var kokart : Bool?
    var value2 : String?
    var text2 : String?
    var gDE_TYPE : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        value <- map["Value"]
        text <- map["Text"]
        kokart <- map["Kokart"]
        value2 <- map["Value2"]
        text2 <- map["Text2"]
        gDE_TYPE <- map["GDE_TYPE"]
    }

}
