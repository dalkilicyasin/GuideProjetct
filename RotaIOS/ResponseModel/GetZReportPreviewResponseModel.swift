//
//  GetDailyReportResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.10.2021.
//

import Foundation
import ObjectMapper

struct GetZReportPreviewResponseModel : Mappable {
    var id : String?
    var reportDateTime : String?
    var zReportNo : String?
    var guide : String?
    var collector : String?
    var createdUser : String?
    var reportPreview : [ReportPreview]?
    var reportTotal : [ReportTotal]?
    var tourRefund : [TourRefund]?
    var hotelAndFlight : [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        reportDateTime <- map["ReportDateTime"]
        zReportNo <- map["ZReportNo"]
        guide <- map["Guide"]
        collector <- map["Collector"]
        createdUser <- map["CreatedUser"]
        reportPreview <- map["reportPreview"]
        reportTotal <- map["reportTotal"]
        tourRefund <- map["tourRefund"]
        hotelAndFlight <- map["hotelAndFlight"]
    }
}


