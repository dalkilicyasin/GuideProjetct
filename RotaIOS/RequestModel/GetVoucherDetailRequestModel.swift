//
//  GetVoucherDetailRequestModel.swift
//  RotaIOS
//
//  Created by Yasin Dalkilic on 26.08.2021.
//

import Foundation
import UIKit
import ObjectMapper

public class  GetVoucherDetailRequestModel : Mappable{
    public var Voucher : String!
  
    public required init?(map: Map) {
        
    }
    
    public init( Voucher : String) {
        self.Voucher = Voucher
    }
    
    public func mapping(map: Map) {
    }
    
    public func requestPathString()->String{
        // 2. parametre eklemek için & işareti koy
        return "?voucher=\(self.Voucher ?? "")"
    }
}
