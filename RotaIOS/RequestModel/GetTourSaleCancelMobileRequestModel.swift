//
//  GetTourSaleCancelMobileRequestModel..swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 8.09.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetTourSaleCancelMobileRequestModel : Mappable{
    public var GuideId : String!
    public var CancelConditionId : String!
    public var Note : String!
    public var ChangeVoucher : String!
    public var TourSaleId : String!
    public var Amount : String!
    public var CurrencyId : String!
    public var PaymentType : String!
  
    public required init?(map: Map) {
        
    }
    
    public init( GuideId : String, CancelConditionId : String, Note : String, ChangeVoucher : String, TourSaleId : String, Amount : String, CurrencyId : String, PaymentType : String) {
        self.GuideId = GuideId
        self.CancelConditionId = CancelConditionId
        self.Note = Note
        self.ChangeVoucher = ChangeVoucher
        self.TourSaleId = TourSaleId
        self.Amount = Amount
        self.CurrencyId = CurrencyId
        self.PaymentType = PaymentType
    }
    
    public func mapping(map: Map) {
        GuideId <- map["GuideId"]
        CancelConditionId <- map["CancelConditionId"]
        Note <- map["Note"]
        ChangeVoucher <- map["ChangeVoucher"]
        TourSaleId <- map["TourSaleId"]
        Amount <- map["Amount"]
        CurrencyId <- map["CurrencyId"]
        PaymentType <- map["PaymentType"]
    }
}
