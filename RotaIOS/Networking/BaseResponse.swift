//
//  BaseResponse.swift
//  BaseProject
//
//  Created by Akif's Mac on 19.02.2019.
//  Copyright © 2019 OtiHolding. All rights reserved.
//
import ObjectMapper

public class BaseResponse<T:Mappable >:Mappable{
    
    public var token :String?
    public var isSuccess :Bool?
    public var threadGuid :String?
    public var baseMessageList :BaseMessageItem?
    public var dataArray: [T]?
    public var dataObject: T?
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        token <- map["Token"]
        isSuccess <- map["IsSuccess"]
        threadGuid <- map["ThreadGuid"]
        baseMessageList <- map["BaseMessage"]
        dataObject <- map["Data"]
        dataArray <- map["Data"]
        
    }
}


public class GetTokenResponse:Mappable{
    
   public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        
    }
}

