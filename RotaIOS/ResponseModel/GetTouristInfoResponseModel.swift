//
//  GetTouristInfoResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 16.05.2021.
//

import Foundation
import ObjectMapper

struct GetTouristInfoResponseModel : Mappable {
    var id : String?
    var touristIdRef : Int?
    var gender : String?
    var ageGroup : String?
    var name : String?
    var birthDay : String?
    var resNo : String?
    var oprId : Int?
    var `operator` : String?
    var passport : String?
    var room : String?
    var hotelId : Int?
    var hotelName : String?
    var age : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["$id"]
        touristIdRef <- map["TouristIdRef"]
        gender <- map["Gender"]
        ageGroup <- map["AgeGroup"]
        name <- map["Name"]
        birthDay <- map["BirthDay"]
        resNo <- map["ResNo"]
        oprId <- map["OprId"]
        `operator` <- map["Operator"]
        passport <- map["Passport"]
        room <- map["Room"]
        hotelId <- map["HotelId"]
        hotelName <- map["HotelName"]
        age <- map["Age"]
    }

}
