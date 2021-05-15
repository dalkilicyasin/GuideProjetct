//
//  GetSelectListResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 12.05.2021.
//

import Foundation
import ObjectMapper

struct GetSelectListResponseModel : Mappable {
    var id : String?
    var value : Int?
    var text : String?
    var cMP_TYPE : Int?
    var sTATUS : Int?
    var companyGroup : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        value <- map["Value"]
        text <- map["Text"]
        cMP_TYPE <- map["CMP_TYPE"]
        sTATUS <- map["STATUS"]
        companyGroup <- map["CompanyGroup"]
    }

}
