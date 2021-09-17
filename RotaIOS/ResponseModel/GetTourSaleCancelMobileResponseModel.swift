//
//  GetTourSaleCancelMobileResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 17.09.2021.
//

import Foundation
import ObjectMapper

struct GetTourSaleCancelMobileResponseModel : Mappable {
    var id : String?
    var Record : Int?
    var IsSuccesful : Bool?
    var Message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        Record <- map["Record"]
        IsSuccesful <- map["IsSuccesful"]
        Message <- map["Message"]
    }
}
