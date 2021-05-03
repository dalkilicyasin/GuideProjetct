//
//  GetTokenResponseModel.swift
//  Rota
//
//  Created by Yasin Dalkilic on 5.04.2021.
//

import Foundation

import Foundation
import ObjectMapper

struct GetTokenResponseModel : Mappable {
    var id : String?
    var access_token : String?
    var token_type : String?
    var expires_in : Double?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        expires_in <- map["expires_in"]
    }

}
