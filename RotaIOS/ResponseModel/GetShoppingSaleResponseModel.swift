//
//  GetShoppingSaleResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 13.08.2021.
//

import Foundation
import ObjectMapper
import UIKit

struct GetShoppingSaleResponseModel : Mappable {
    var id : String?
    var Id : Int?
    var paxes : String?
    var hotel : String?
    var steps : String?
    var stepStates : String?
    var totalCount : String?
    var oprName : String?
    var plates : String?
    var room : String?
    var note : String?
    var voucherNo : String?
    var shoppingGuideNote : String?
    var shopDateStr : String?
    var pickupTimeStr : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        Id <- map["Id"]
        paxes <- map["Paxes"]
        hotel <- map["Hotel"]
        steps <- map["Steps"]
        stepStates <- map["StepStates"]
        totalCount <- map["TotalCount"]
        oprName <- map["OprName"]
        plates <- map["Plates"]
        room <- map["Room"]
        note <- map["Note"]
        voucherNo <- map["VoucherNo"]
        shoppingGuideNote <- map["ShoppingGuideNote"]
        shopDateStr <- map["ShopDateStr"]
        pickupTimeStr <- map["PickupTimeStr"]
    }

}

