//
//  GetSaveForMobileRequestList.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 14.05.2021.
//

import Foundation
import ObjectMapper

public class Paxes : Mappable, Encodable, Decodable {
    
    public var action = 1 // 1
    public var iD = 0 // 0
    public var pAX_CHECKOUT_DATE : String!
    public var pAX_ID = 0 // 0
    public var pAX_OPRID : Int!
    public var pAX_OPRNAME : String!
    public var pAX_OPRTYPE = 1 // 1
    public var pAX_ROWVERSION = 1 // 1
    public var pAX_PHONE = "" // ""
    public var hotelname : String?
    public var pAX_GENDER : String!
    public var pAX_SOURCEREF = 0 // 0
    public var pAX_AGEGROUP : String!
    public var pAX_NAME : String!
    public var pAX_BIRTHDAY : String!
    public var pAX_RESNO : String!
    public  var pAX_PASSPORT : String!
    public  var pAX_ROOM : String!
    public var pAX_TOURISTREF : Int!
    public  var pAX_STATUS : Int!
    public required init?(map: Map) {
        
    }
    
    public init(  pAX_CHECKOUT_DATE : String, pAX_OPRID : Int, pAX_OPRNAME : String, pAX_PHONE : String, hotelname : String?, pAX_GENDER : String, pAX_AGEGROUP : String, pAX_NAME : String,pAX_BIRTHDAY : String,pAX_RESNO : String,pAX_PASSPORT : String, pAX_ROOM : String, pAX_TOURISTREF : Int, pAX_STATUS : Int) {
        
        self.pAX_AGEGROUP = pAX_AGEGROUP
        self.pAX_BIRTHDAY = pAX_BIRTHDAY
        self.pAX_CHECKOUT_DATE = pAX_CHECKOUT_DATE
        self.pAX_GENDER = pAX_GENDER
        self.pAX_NAME = pAX_NAME
        self.pAX_OPRID = pAX_OPRID
        self.pAX_OPRNAME = pAX_OPRNAME
        self.pAX_PASSPORT = pAX_PASSPORT
        self.pAX_PHONE = pAX_PHONE
        self.pAX_RESNO = pAX_RESNO
        self.pAX_ROOM = pAX_ROOM
        self.pAX_STATUS = pAX_STATUS
        self.pAX_TOURISTREF = pAX_TOURISTREF
        self.hotelname = hotelname
        
    }
    
    
    public func mapping(map: Map) {
        
        action <- map["Action"]
        iD <- map["ID"]
        pAX_AGEGROUP <- map["PAX_AGEGROUP"]
        pAX_BIRTHDAY <- map["PAX_BIRTHDAY"]
        pAX_CHECKOUT_DATE <- map["PAX_CHECKOUT_DATE"]
        pAX_GENDER <- map["PAX_GENDER"]
        pAX_ID <- map["PAX_ID"]
        pAX_NAME <- map["PAX_NAME"]
        pAX_OPRID <- map["PAX_OPRID"]
        pAX_OPRNAME <- map["PAX_OPRNAME"]
        pAX_OPRTYPE <- map["PAX_OPRTYPE"]
        pAX_PASSPORT <- map["PAX_PASSPORT"]
        pAX_PHONE <- map["PAX_PHONE"]
        pAX_RESNO <- map["PAX_RESNO"]
        pAX_ROOM <- map["PAX_ROOM"]
        pAX_ROWVERSION <- map["PAX_ROWVERSION"]
        pAX_SOURCEREF <- map["PAX_SOURCEREF"]
        pAX_STATUS <- map["PAX_STATUS"]
        pAX_TOURISTREF <- map["PAX_TOURISTREF"]
        hotelname <- map["hotelname"]
    }
    
}

public class Steps : Mappable {
    public var sTP_COMPANY : Int!
    public  var sTP_NOTE : String!
    public  var sTP_ID : Int!
    public  var sTP_ADULTCOUNT : Int!
    public var sTP_CHILDCOUNT : Int! // child CHD
    public  var sTP_INFANTCOUNT : Int! // inf INF
    public var sTP_SHOPREF : Int!
    public  var sTP_STATUS : Int!
    public  var sTP_ORDER : Int!
    public var name : String!
    public var sTP_STATE : Int!
    
    public required init?(map: Map) {
        
    }
    
    public init( sTP_STATE: Int, name : String ,sTP_COMPANY : Int, sTP_NOTE : String, sTP_ID : Int, sTP_ADULTCOUNT : Int, sTP_CHILDCOUNT : Int, sTP_INFANTCOUNT : Int, sTP_SHOPREF : Int, sTP_STATUS : Int, sTP_ORDER : Int ) {
        self.sTP_COMPANY = sTP_COMPANY
        self.sTP_NOTE = sTP_NOTE
        self.sTP_ID = sTP_ID
        self.sTP_ADULTCOUNT = sTP_ADULTCOUNT
        self.sTP_CHILDCOUNT = sTP_CHILDCOUNT
        self.sTP_INFANTCOUNT = sTP_INFANTCOUNT
        self.sTP_SHOPREF = sTP_SHOPREF
        self.sTP_STATUS = sTP_STATUS
        self.sTP_ORDER = sTP_ORDER
        self.name = name
        self.sTP_STATE = sTP_STATE
        
    }
    
    public func mapping(map: Map) {
        
        sTP_ADULTCOUNT <- map["STP_ADULTCOUNT"]
        sTP_CHILDCOUNT <- map["STP_CHILDCOUNT"]
        sTP_COMPANY <- map["STP_COMPANY"]
        sTP_ID <- map["STP_ID"]
        sTP_INFANTCOUNT <- map["STP_INFANTCOUNT"]
        sTP_NOTE <- map["STP_NOTE"]
        sTP_ORDER <- map["STP_ORDER"]
        sTP_SHOPREF <- map["STP_SHOPREF"]
        sTP_STATE <- map["STP_STATE"]
        sTP_STATUS <- map["STP_STATUS"]
        name <- map["name"]
    }
    
}

public class GetSaveForMobileRequestList : Mappable {
    
   /* public  var ID = 0
    public var iND_ID = 0
    public var iND_STATUS = 1
    public var iND_VOUCHER = ""
    public var action = 1
    public var iND_INFMINAGE = "0"
    public var iND_INFMAXAGE = "0"
    public var iND_CHLMINAGE = "0"
    public var iND_ROWVERSION = 0
    public var iND_AGE_EE = true
    public var iND_ISREPEAT = false */
    public var iND_ID = 0
    public var iND_SHOPDATE : String!
    public var iND_GUIDEREF : Int!
    public var iND_MARKETGROUPREF : Int! // Getguide infoan dönen  marketgrpid
    public var iND_MARKETREF : Int! // market value(id)
    public var iND_AREAREF : Int! // Gethotelsmobile servisindeki area yazan değer
    public var iND_HOTELREF : Int! // Gethotelsmobile servisindeki  value yazan yer
    public var iND_NOTE : Any!
    public var iND_ISREPEAT = false // check box işaretlenirse true yoksa false
    public var iND_INFMINAGE = 0.0
    public var iND_INFMAXAGE = 0.0
    public var iND_CHLMINAGE = 0.0
    public var iND_CHLMAXAGE : Any! // cenker beyde yok
    public var iND_AGE_EE = true
    public var iND_SHOPPICKUPTIME : String!
   // public var iND_ISSENT =  true // belirsiz cenker beyde yok
    public var iND_ROWVERSION = 0
    public var iND_VOUCHER : Any! // bu şekilde gönderip response da message da numara dönüyor.Sonra kullanacağız.
    public var iND_STATUS = 1
    public var strPaxes : String!
    public var strSteps : String!
    public var iD = 0
    public var action = 1
    
   
    public required init?(map: Map) {
        
    }
    
    
    public init(iND_CHLMAXAGE : Any, iND_NOTE : Any, iND_VOUCHER : Any, iND_SHOPDATE : String, iND_GUIDEREF : Int, iND_MARKETGROUPREF : Int, iND_MARKETREF : Int, iND_AREAREF : Int, iND_HOTELREF : Int, iND_SHOPPICKUPTIME : String, strPaxes : String, strSteps : String ) {
        
        self.iND_SHOPDATE = iND_SHOPDATE
        self.iND_GUIDEREF = iND_GUIDEREF
        self.iND_MARKETGROUPREF = iND_MARKETGROUPREF
        self.iND_MARKETREF = iND_MARKETREF
        self.iND_AREAREF = iND_AREAREF
        self.iND_HOTELREF = iND_HOTELREF
        self.strPaxes = strPaxes
        self.strSteps = strSteps
        self.iND_SHOPPICKUPTIME = iND_SHOPPICKUPTIME
        self.iND_VOUCHER = iND_VOUCHER
        self.iND_NOTE = iND_NOTE
        self.iND_CHLMAXAGE = iND_CHLMAXAGE
    }
    

    public func mapping(map: Map) {
        iND_ID <- map["IND_ID"]
        iND_SHOPDATE <- map["IND_SHOPDATE"]
        iND_GUIDEREF <- map["IND_GUIDEREF"]
        iND_MARKETGROUPREF <- map["IND_MARKETGROUPREF"]
        iND_MARKETREF <- map["IND_MARKETREF"]
        iND_AREAREF <- map["IND_AREAREF"]
        iND_HOTELREF <- map["IND_HOTELREF"]
        iND_NOTE <- map["IND_NOTE"]
        iND_ISREPEAT <- map["IND_ISREPEAT"]
        iND_INFMINAGE <- map["IND_INFMINAGE"]
        iND_INFMAXAGE <- map["IND_INFMAXAGE"]
        iND_CHLMINAGE <- map["IND_CHLMINAGE"]
     //   iND_CHLMAXAGE <- map["IND_CHLMAXAGE"]
        iND_AGE_EE <- map["IND_AGE_EE"]
        iND_SHOPPICKUPTIME <- map["IND_SHOPPICKUPTIME"]
     //   iND_ISSENT <- map["IND_ISSENT"]
        iND_ROWVERSION <- map["IND_ROWVERSION"]
        iND_VOUCHER <- map["IND_VOUCHER"]
        iND_STATUS <- map["IND_STATUS"]
        strPaxes <- map["StrPaxes"]
        strSteps <- map["StrSteps"]
        iD <- map["ID"]
        action <- map["Action"]
    }
}


