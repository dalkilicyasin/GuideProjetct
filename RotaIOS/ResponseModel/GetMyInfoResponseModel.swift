//
//  GetMyInfoResponseModel.swift
//  Rota
//
//  Created by Yasin Dalkilic on 15.04.2021.
//

import Foundation
import ObjectMapper

struct GetMyInfoResponseModel : Mappable {
    var id : String?
    var uSR_DESC : String?
    var uSR_EMAIL : String?
    var uSR_ID : Int?
    var rOLE_ID : Int?
    var companyId : String?
    var guideId : Int?
    var type : String?
    var name : String?
    var description : String?
    var centerOffice : Bool?
    var phoneNumber : String?
    var officeId : Int?
    var isDb2User : Bool?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        uSR_DESC <- map["USR_DESC"]
        uSR_EMAIL <- map["USR_EMAIL"]
        uSR_ID <- map["USR_ID"]
        rOLE_ID <- map["ROLE_ID"]
        companyId <- map["CompanyId"]
        guideId <- map["GuideId"]
        type <- map["Type"]
        name <- map["Name"]
        description <- map["Description"]
        centerOffice <- map["CenterOffice"]
        phoneNumber <- map["PhoneNumber"]
        officeId <- map["OfficeId"]
        isDb2User <- map["IsDb2User"]
    }

}
