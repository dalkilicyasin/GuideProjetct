//
//  GetCalculateCancelFeeRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 31.08.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetCalculateCancelFeeRequestModel : Mappable{
    public var cancelReasonId : Int!
    public var saleId : Int!
  
    public required init?(map: Map) {
        
    }
    
    public init( cancelReasonId : Int, saleId : Int) {
        self.cancelReasonId = cancelReasonId
        self.saleId = saleId
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?cancelReasonId=\(self.cancelReasonId ?? 0)&saleId=\(self.saleId ?? 0)"
    }
}
