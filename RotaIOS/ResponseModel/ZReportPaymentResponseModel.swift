//
//  ZReportPaymentResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 28.09.2021.
//

import Foundation
import ObjectMapper

struct ZReportPaymentResponseModel : Mappable {
    var id : String?
    var voucherNo : String?
    var saleDate : String?
    var tourName : String?
    var tourDate : String?
    var paymentId : Int?
    var paidBy : String?
    var paymentType : String?
    var paymentAmount : Double?
    var paymentCurrency : String?
    var paymentCurrencyDesc : String?
    var iD : Int?
    var action : Int?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        voucherNo <- map["VoucherNo"]
        saleDate <- map["SaleDate"]
        tourName <- map["TourName"]
        tourDate <- map["TourDate"]
        paymentId <- map["PaymentId"]
        paidBy <- map["PaidBy"]
        paymentType <- map["PaymentType"]
        paymentAmount <- map["PaymentAmount"]
        paymentCurrency <- map["PaymentCurrency"]
        paymentCurrencyDesc <- map["PaymentCurrencyDesc"]
        iD <- map["ID"]
        action <- map["Action"]
    }
}
