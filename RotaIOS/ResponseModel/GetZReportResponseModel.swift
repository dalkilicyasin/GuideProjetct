//
//  GetZReportResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 20.09.2021.
//

import Foundation
import ObjectMapper

struct GetZReportResponseModel : Mappable {
    var id : String?
    var reportCreateDate : String?
    var zReportNo : Int?
    var guideRef : Int?
    var collectionState : Int?
    var collectionStateDesc : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        reportCreateDate <- map["ReportCreateDate"]
        zReportNo <- map["ZReportNo"]
        guideRef <- map["GuideRef"]
        collectionState <- map["CollectionState"]
        collectionStateDesc <- map["CollectionStateDesc"]
    }

}
