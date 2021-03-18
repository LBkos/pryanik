//
//  ApiModel.swift
//  tzJson
//
//  Created by Константин Лопаткин on 21.02.2021.
//

import Foundation
import SwiftyJSON


class ApiData : NSObject, NSCoding{

    var response : [Response]!
    var success : Bool!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        response = [Response]()
        let responseArray = json["response"].arrayValue
        for responseJson in responseArray{
            let value = Response(fromJson: responseJson)
            response.append(value)
        }
        success = json["success"].boolValue
    }
    
    @objc required init(coder aDecoder: NSCoder) {
    response = aDecoder.decodeObject(forKey: "response") as? [Response]
    success = aDecoder.decodeObject(forKey: "success") as? Bool
}
    func encode(with aCoder: NSCoder) {
    if response != nil {
        aCoder.encode(response, forKey: "response")
    }
    if success != nil {
        aCoder.encode(success, forKey: "success")
    }
}
}
class Response : NSObject, NSCoding, Codable{
    
    var amount : String!
    var created : Int!
    var currency : String!
    var desc : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        amount = json["amount"].stringValue
        created = json["created"].intValue
        currency = json["currency"].stringValue
        desc = json["desc"].stringValue
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        amount = aDecoder.decodeObject(forKey: "amount") as? String
        created = aDecoder.decodeObject(forKey: "created") as? Int
        currency = aDecoder.decodeObject(forKey: "currency") as? String
        desc = aDecoder.decodeObject(forKey: "desc") as? String
    }
    func encode(with aCoder: NSCoder) {
            if amount != nil{
                aCoder.encode(amount, forKey: "amount")
            }
            if created != nil{
                aCoder.encode(created, forKey: "created")
            }
            if currency != nil{
                aCoder.encode(currency, forKey: "currency")
            }
            if desc != nil{
                aCoder.encode(desc, forKey: "desc")
            }

        }

    }

class Token : NSObject, NSCoding{

    var response : Responses?
    var success : Bool!
    var error : Errors?

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let responseJson = json["response"]
        if !responseJson.isEmpty{
            response = Responses(fromJson: responseJson)
        }
        success = json["success"].boolValue
        error = Errors(fromJson: json["error"])
    }

    @objc required init(coder aDecoder: NSCoder) {
        response = aDecoder.decodeObject(forKey: "response") as? Responses
        success = aDecoder.decodeObject(forKey: "success") as? Bool
    }

    func encode(with aCoder: NSCoder) {
        if response != nil{
            aCoder.encode(response, forKey: "response")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}
class Responses : NSObject, NSCoding {

    var token : String!

    init(fromJson json: JSON!) {
        if json.isEmpty{
            return
        }
        token = json["token"].stringValue
    }

    @objc required init(coder aDecoder: NSCoder) {
        token = aDecoder.decodeObject(forKey: "token") as? String
    }

    func encode(with aCoder: NSCoder) {
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
    }
}
class Errors : NSObject, NSCoding{

    var errorCode : Int?
    var errorMsg : String?

    init(fromJson json: JSON!) {
        
        if json.isEmpty{
            return
        }
        errorCode = json["error_code"].intValue
        errorMsg = json["error_msg"].stringValue
    }

    @objc required init(coder aDecoder: NSCoder) {
        
        errorCode = aDecoder.decodeObject(forKey: "error_code") as? Int
        errorMsg = aDecoder.decodeObject(forKey: "error_msg") as? String
    }

    func encode(with aCoder: NSCoder) {
       
        if errorCode != nil {
            aCoder.encode(errorCode, forKey: "error_code")
        }
        if errorMsg != nil {
            aCoder.encode(errorMsg, forKey: "error_msg")
        }
    }
}

