//
//  GetSaveForMobileRequestList.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 14.05.2021.
//

import Foundation
import ObjectMapper

public class Paxes : Mappable {
    
    
    
    public var pAX_GENDER : String!
    public var pAX_SOURCEREF : String!
    public var pAX_AGEGROUP : String!
    public var pAX_NAME : String!
    public var pAX_BIRTHDAY : String!
    public var pAX_RESNO : String!
    public  var pAX_PASSPORT : String!
    public  var pAX_ROOM : String!
    public var pAX_TOURISTREF : String!
    public  var pAX_STATUS : Int!
    
    public required init?(map: Map) {
        
    }
    
    public init( pAX_GENDER : String, pAX_SOURCEREF : String, pAX_AGEGROUP : String, pAX_NAME : String,pAX_BIRTHDAY : String,pAX_RESNO : String,pAX_PASSPORT : String,pAX_ROOM : String, pAX_TOURISTREF : String, pAX_STATUS : Int) {
        self.pAX_GENDER = pAX_GENDER
        self.pAX_SOURCEREF = pAX_SOURCEREF
        self.pAX_AGEGROUP = pAX_AGEGROUP
        self.pAX_NAME = pAX_NAME
        self.pAX_BIRTHDAY = pAX_BIRTHDAY
        self.pAX_RESNO = pAX_RESNO
        self.pAX_PASSPORT = pAX_PASSPORT
        self.pAX_ROOM = pAX_ROOM
        self.pAX_TOURISTREF = pAX_TOURISTREF
        self.pAX_STATUS = pAX_STATUS
        
    }
    
    
    public func mapping(map: Map) {
        
        pAX_GENDER <- map["PAX_GENDER"]
        pAX_SOURCEREF <- map["PAX_SOURCEREF"]
        pAX_AGEGROUP <- map["PAX_AGEGROUP"]
        pAX_NAME <- map["PAX_NAME"]
        pAX_BIRTHDAY <- map["PAX_BIRTHDAY"]
        pAX_RESNO <- map["PAX_RESNO"]
        pAX_PASSPORT <- map["PAX_PASSPORT"]
        pAX_ROOM <- map["PAX_ROOM"]
        pAX_TOURISTREF <- map["PAX_TOURISTREF"]
        pAX_STATUS <- map["PAX_STATUS"]
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
    
    public required init?(map: Map) {
        
    }
    
    public init( sTP_COMPANY : String, sTP_NOTE : String, sTP_ID : String, sTP_ADULTCOUNT : String, sTP_CHILDCOUNT : String, sTP_INFANTCOUNT : String, sTP_SHOPREF : Int, sTP_STATUS : Int, sTP_ORDER : Int ) {
        self.sTP_COMPANY = sTP_COMPANY
        self.sTP_NOTE = sTP_NOTE
        self.sTP_ID = sTP_ID
        self.sTP_ADULTCOUNT = sTP_ADULTCOUNT
        self.sTP_CHILDCOUNT = sTP_CHILDCOUNT
        self.sTP_INFANTCOUNT = sTP_INFANTCOUNT
        self.sTP_SHOPREF = sTP_SHOPREF
        self.sTP_STATUS = sTP_STATUS
        self.sTP_ORDER = sTP_ORDER
        
    }
    
    public func mapping(map: Map) {
        
        sTP_COMPANY <- map["STP_COMPANY"]
        sTP_NOTE <- map["STP_NOTE"]
        sTP_ID <- map["STP_ID"]
        sTP_ADULTCOUNT <- map["STP_ADULTCOUNT"]
        sTP_CHILDCOUNT <- map["STP_CHILDCOUNT"]
        sTP_INFANTCOUNT <- map["STP_INFANTCOUNT"]
        sTP_SHOPREF <- map["STP_SHOPREF"]
        sTP_STATUS <- map["STP_STATUS"]
        sTP_ORDER <- map["STP_ORDER"]
    }
    
}

public class GetSaveForMobileRequestList : Mappable {
 
    
    public var iND_ID : Int!
    public var iND_SHOPDATE : String!
    public var iND_GUIDEREF : String!
    public var iND_MARKETGROUPREF : String!
    public var iND_MARKETREF : String!
    public var iND_AREAREF : String!
    public var iND_NOTE : String!
    public var iND_ISREPEAT : Bool!
    public var iND_HOTELREF : String!
    public var iND_STATUS : Int!
    public var iND_INFMINAGE : String!
    public var iND_INFMAXAGE : String!
    public var iND_CHLMINAGE : String!
    public var iND_CHLMAXAGE : String!
    public var iND_AGE_EE : Bool!
    public var action : Int!
    public var paxes : [Paxes]!
    public var steps : [Steps]!
    public var iND_SHOPPICKUPTIME : String!
    public var iND_ROWVERSION : Int!
    public var iND_VOUCHER : String!
    
    public required init?(map: Map) {
        
    }
    
    
    public init( iND_ID : Int, iND_SHOPDATE : String, iND_GUIDEREF : String, iND_MARKETGROUPREF : String, iND_MARKETREF : String, iND_AREAREF : String, iND_NOTE : String, iND_ISREPEAT : Bool, iND_HOTELREF : String, iND_STATUS : Int, iND_INFMINAGE : String, iND_INFMAXAGE : String, iND_CHLMINAGE : String, iND_CHLMAXAGE : String, iND_AGE_EE : Bool, action : Int, paxes : [Paxes], steps : [Steps], iND_SHOPPICKUPTIME : String, iND_ROWVERSION : Int , iND_VOUCHER : String  ) {
        
        self.iND_ID = iND_ID
        self.iND_SHOPDATE = iND_SHOPDATE
        self.iND_GUIDEREF = iND_GUIDEREF
        self.iND_MARKETGROUPREF = iND_MARKETGROUPREF
        self.iND_MARKETREF = iND_MARKETREF
        self.iND_AREAREF = iND_AREAREF
        self.iND_NOTE = iND_NOTE
        self.iND_ISREPEAT = iND_ISREPEAT
        self.iND_HOTELREF = iND_HOTELREF
        self.iND_STATUS = iND_STATUS
        self.iND_INFMINAGE = iND_INFMINAGE
        self.iND_INFMAXAGE = iND_INFMAXAGE
        self.iND_CHLMINAGE = iND_CHLMINAGE
        self.iND_CHLMAXAGE = iND_CHLMAXAGE
        self.iND_AGE_EE = iND_AGE_EE
        self.action = action
        self.paxes = paxes
        self.steps = steps
        self.iND_SHOPPICKUPTIME = iND_SHOPPICKUPTIME
        self.iND_ROWVERSION = iND_ROWVERSION
        self.iND_VOUCHER = iND_VOUCHER
        self.iND_HOTELREF = iND_HOTELREF
    }
    

    public func mapping(map: Map) {
        
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
        iND_CHLMAXAGE <- map["IND_CHLMAXAGE"]
        iND_AGE_EE <- map["IND_AGE_EE"]
        action <- map["Action"]
        paxes <- map["Paxes"]
        steps <- map["Steps"]
        iND_SHOPPICKUPTIME <- map["IND_SHOPPICKUPTIME"]
        iND_ROWVERSION <- map["IND_ROWVERSION"]
        iND_VOUCHER <- map["IND_VOUCHER"]
    }
    
}


