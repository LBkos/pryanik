import Foundation

struct test: Codable {
    struct view {
       var f: [String]!
    }
    struct data {
        var name: String
    struct data {
        var url: String?
        var text: String?
        var selectedId: Int?
        struct variants {
            var id: Int?
            var text: String?
        }
    }
    }
}


import Foundation
import SwiftyJSON


class datamodel : NSObject, NSCoding{

    var data : [dataDatum]!
    var view : [String]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [dataDatum]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = dataDatum(fromJson: dataJson)
            data.append(value)
        }
        view = [String]()
        let viewArray = json["view"].arrayValue
        for viewJson in viewArray{
            view.append(viewJson.stringValue)
        }
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? [dataDatum]
        view = aDecoder.decodeObject(forKey: "view") as? [String]
    }

    
    func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if view != nil{
            aCoder.encode(view, forKey: "view")
        }

    }

}

class dataDatum : NSObject, NSCoding, Identifiable{
    var id = UUID()
    
    var data : dataDatums!
    var name : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = dataDatums(fromJson: dataJson)
        }
        name = json["name"].stringValue
    }

    
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? dataDatums
        name = aDecoder.decodeObject(forKey: "name") as? String
    }

    func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
    }
}

class dataDatums : NSObject, NSCoding{

    var text: String?
    var url: String?
    var selectedId : Int!
    var variants : [dataVariant]!

    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        text = json["text"].stringValue
        url = json["url"].stringValue
        selectedId = json["selectedId"].intValue
        variants = [dataVariant]()
        let variantsArray = json["variants"].arrayValue
        for variantsJson in variantsArray{
            let value = dataVariant(fromJson: variantsJson)
            variants.append(value)
        }
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        selectedId = aDecoder.decodeObject(forKey: "selectedId") as? Int
        variants = aDecoder.decodeObject(forKey: "variants") as? [dataVariant]
    }

    func encode(with aCoder: NSCoder)
    {
        if selectedId != nil{
            aCoder.encode(selectedId, forKey: "selectedId")
        }
        if variants != nil{
            aCoder.encode(variants, forKey: "variants")
        }

    }

}

class dataVariant : NSObject, NSCoding{

    var id : Int!
    var text : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        text = json["text"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if text != nil{
            dictionary["text"] = text
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        text = aDecoder.decodeObject(forKey: "text") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if text != nil{
            aCoder.encode(text, forKey: "text")
        }

    }

}


