//
//  GetReportDataResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 22.09.2021.
//

import Foundation
import ObjectMapper

struct GetReportDataResponseModel : Mappable {
    var id : String?
    var reportDateTime : String?
    var zReportNo : String?
    var guide : String?
    var collector : String?
    var createdUser : String?
    var reportPreview : [ReportPreview]?
    var reportTotal : [ReportTotal]?
    var tourRefund : [String]?
    var hotelAndFlight : [String]?

    init?(map: Map) {

    }
    
    init() {
        
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

struct ReportPreview : Mappable {
    var id : String?
    var saleType : String?
    var paymentType : String?
    var saleAmount : String?
    var refundAmount : String?
    var balanceAmount : String?
    var currencyType : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        saleType <- map["SaleType"]
        paymentType <- map["PaymentType"]
        saleAmount <- map["SaleAmount"]
        refundAmount <- map["RefundAmount"]
        balanceAmount <- map["BalanceAmount"]
        currencyType <- map["CurrencyType"]
    }
}

struct ReportTotal : Mappable {
    var id : String?
    var paymentType : String?
    var amount : String?
    var currencyType : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        paymentType <- map["PaymentType"]
        amount <- map["Amount"]
        currencyType <- map["CurrencyType"]
    }
}
