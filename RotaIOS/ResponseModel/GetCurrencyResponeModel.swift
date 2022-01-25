//
//  GetCurrencyResponeModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 23.12.2021.
//

import Foundation
import ObjectMapper

struct GetCurrencyResponeModel : Mappable, Decodable, Encodable {
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
