//
//  GetSaveForMobileRequestList.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 14.05.2021.
//

import Foundation
import ObjectMapper

public class Paxes : Mappable {
    
    public var action : Int!
    public var iD : Int!
    public var pAX_CHECKOUT_DATE : String!
    public var pAX_ID : Int!
    public var pAX_OPRID : Int!
    public var pAX_OPRNAME : String!
    public var pAX_OPRTYPE : Int!
    public var pAX_ROWVERSION : Int!
    public var pAX_PHONE : String!
    public var hotelname : String?
    public var pAX_GENDER : String!
    public var pAX_SOURCEREF : Int!
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
    
    public init(  action : Int,iD : Int, pAX_CHECKOUT_DATE : String, pAX_ID : Int, pAX_OPRID : Int, pAX_OPRNAME : String, pAX_OPRTYPE : Int, pAX_ROWVERSION : Int, pAX_PHONE : String, hotelname : String?,pAX_GENDER : String, pAX_SOURCEREF : Int, pAX_AGEGROUP : String, pAX_NAME : String,pAX_BIRTHDAY : String,pAX_RESNO : String,pAX_PASSPORT : String, pAX_ROOM : String, pAX_TOURISTREF : Int, pAX_STATUS : Int) {
        
        self.action = action
        self.iD = iD
        self.pAX_AGEGROUP = pAX_AGEGROUP
        self.pAX_BIRTHDAY = pAX_BIRTHDAY
        self.pAX_CHECKOUT_DATE = pAX_CHECKOUT_DATE
        self.pAX_GENDER = pAX_GENDER
        self.pAX_ID = pAX_ID
        self.pAX_NAME = pAX_NAME
        self.pAX_OPRID = pAX_OPRID
        self.pAX_OPRNAME = pAX_OPRNAME
        self.pAX_OPRTYPE = pAX_OPRTYPE
        self.pAX_PASSPORT = pAX_PASSPORT
        self.pAX_PHONE = pAX_PHONE
        self.pAX_RESNO = pAX_RESNO
        self.pAX_ROOM = pAX_ROOM
        self.pAX_ROWVERSION = pAX_ROWVERSION
        self.pAX_SOURCEREF = pAX_SOURCEREF
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
 
    
    public var sTP_COMPANY : String!
    public  var sTP_NOTE : String!
    public  var sTP_ID : String!
    public  var sTP_ADULTCOUNT : String!
    public var sTP_CHILDCOUNT : String!
    public  var sTP_INFANTCOUNT : String!
    public var sTP_SHOPREF : Int!
    public  var sTP_STATUS : Int!
    public  var sTP_ORDER : Int!
    public var name : String!
    public var sTP_STATE : Int!
    
    public required init?(map: Map) {
        
    }
    
    public init( sTP_STATE: Int, name : String ,sTP_COMPANY : String, sTP_NOTE : String, sTP_ID : String, sTP_ADULTCOUNT : String, sTP_CHILDCOUNT : String, sTP_INFANTCOUNT : String, sTP_SHOPREF : Int, sTP_STATUS : Int, sTP_ORDER : Int ) {
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
    
    public  var ID = 0
    public var iND_ID = 0
    public var iND_STATUS = 1
    public var iND_VOUCHER = ""
    public var action = 1
    public var iND_INFMINAGE = "0"
    public var iND_INFMAXAGE = "0"
    public var iND_CHLMINAGE = "0"
    public var iND_ROWVERSION = 0
    public var iND_AGE_EE = true
    public var iND_ISREPEAT = false
    public var iND_SHOPDATE : String!
    public var iND_GUIDEREF : String!
    public var iND_MARKETGROUPREF : String!
    public var iND_MARKETREF : String!
    public var iND_AREAREF : String!
    public var iND_NOTE : String!
    public var iND_HOTELREF : String!
    public var paxes : [Paxes]!
    public var steps : [Steps]!
    public var iND_SHOPPICKUPTIME : String!
    
   
    public required init?(map: Map) {
        
    }
    
    
    public init(  iND_SHOPDATE : String, iND_GUIDEREF : String, iND_MARKETGROUPREF : String, iND_MARKETREF : String, iND_AREAREF : String, iND_NOTE : String, iND_HOTELREF : String, iND_STATUS : Int,  action : Int, paxes : [Paxes], steps : [Steps], iND_SHOPPICKUPTIME : String ) {
        
        self.iND_SHOPDATE = iND_SHOPDATE
        self.iND_GUIDEREF = iND_GUIDEREF
        self.iND_MARKETGROUPREF = iND_MARKETGROUPREF
        self.iND_MARKETREF = iND_MARKETREF
        self.iND_AREAREF = iND_AREAREF
        self.iND_NOTE = iND_NOTE
        self.iND_HOTELREF = iND_HOTELREF
        self.iND_STATUS = iND_STATUS
        self.action = action
        self.paxes = paxes
        self.steps = steps
        self.iND_SHOPPICKUPTIME = iND_SHOPPICKUPTIME
       
    }
    

    public func mapping(map: Map) {
        ID <- map["ID"]
        iND_ID <- map["IND_ID"]
        iND_SHOPDATE <- map["IND_SHOPDATE"]
        iND_GUIDEREF <- map["IND_GUIDEREF"]
        iND_MARKETGROUPREF <- map["IND_MARKETGROUPREF"]
        iND_MARKETREF <- map["IND_MARKETREF"]
        iND_AREAREF <- map["IND_AREAREF"]
        iND_NOTE <- map["IND_NOTE"]
        iND_ISREPEAT <- map["IND_ISREPEAT"]
        iND_HOTELREF <- map["IND_HOTELREF"]
        iND_STATUS <- map["IND_STATUS"]
        iND_INFMINAGE <- map["IND_INFMINAGE"]
        iND_INFMAXAGE <- map["IND_INFMAXAGE"]
        iND_CHLMINAGE <- map["IND_CHLMINAGE"]
        iND_AGE_EE <- map["IND_AGE_EE"]
        action <- map["Action"]
        paxes <- map["Paxes"]
        steps <- map["Steps"]
        iND_SHOPPICKUPTIME <- map["IND_SHOPPICKUPTIME"]
        iND_ROWVERSION <- map["IND_ROWVERSION"]
        iND_VOUCHER <- map["IND_VOUCHER"]
    }
    
}


