//
//  GetCalculateCancelFeeResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 31.08.2021.
//

import Foundation
import ObjectMapper

struct GetCalculateCancelFeeResponseModel : Mappable {
    var id : String?
    var refundAmount : Double?
    var amount : Double?
    var currencyId : Int?
    var currencyCode : String?
    var currencyDesc : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        refundAmount <- map["RefundAmount"]
        amount <- map["Amount"]
        currencyId <- map["CurrencyId"]
        currencyCode <- map["CurrencyCode"]
        currencyDesc <- map["CurrencyDesc"]
    }
}
