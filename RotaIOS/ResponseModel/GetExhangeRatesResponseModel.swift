//
//  GetExhangeRatesResponseModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 24.12.2021.
//
import Foundation
import ObjectMapper

struct GetExhangeRatesResponseModel : Mappable, Decodable, Encodable {
    var id : String?
    var bEGINDATE : String?
    var eNDDATE : String?
    var cURREF : Int?
    var sHORTCODE : String?
    var bUYRATE : Double?
    var sELLRATE : Double?
    var eFFECTIVEBUY : Double?
    var eFFECTIVESELL : Double?
    var uSDCROSS : Double?
    var eUROCROSS : Double?
    var rUBCROSS : Double?
    var tYPE : Int?
    var sTATUS : Int?
    var tYPEKEY : String?
    var iD : Int?
    var action : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        bEGINDATE <- map["BEGINDATE"]
        eNDDATE <- map["ENDDATE"]
        cURREF <- map["CURREF"]
        sHORTCODE <- map["SHORTCODE"]
        bUYRATE <- map["BUYRATE"]
        sELLRATE <- map["SELLRATE"]
        eFFECTIVEBUY <- map["EFFECTIVEBUY"]
        eFFECTIVESELL <- map["EFFECTIVESELL"]
        uSDCROSS <- map["USDCROSS"]
        eUROCROSS <- map["EUROCROSS"]
        rUBCROSS <- map["RUBCROSS"]
        tYPE <- map["TYPE"]
        sTATUS <- map["STATUS"]
        tYPEKEY <- map["TYPEKEY"]
        iD <- map["ID"]
        action <- map["Action"]
    }

}
