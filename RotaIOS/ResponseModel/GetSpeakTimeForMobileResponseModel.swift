//
//  GetSpeakTimeForMobileResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 15.09.2021.
//

import Foundation
import ObjectMapper

struct GetSpeakTimeForMobileResponseModel : Mappable {
    var id : String?
    var Id : Int?
    var guideId : Int?
    var guideDesc : String?
    var startDate : String?
    var hotelName : String?
    var endDate : String?
    var startTime : String?
    var endTime : String?
    var days : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        Id <- map["Id"]
        guideId <- map["GuideId"]
        guideDesc <- map["GuideDesc"]
        startDate <- map["StartDate"]
        hotelName <- map["HotelName"]
        endDate <- map["EndDate"]
        startTime <- map["StartTime"]
        endTime <- map["EndTime"]
        days <- map["Days"]
    }
}
