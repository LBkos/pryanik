import Foundation
import SwiftyJSON

class DataModel : NSObject, NSCoding{

    var data : [Data]!
    var view : [String]!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        data = [Data]()
        let dataArray = json["data"].arrayValue
        for dataJson in dataArray{
            let value = Data(fromJson: dataJson)
            data.append(value)
        }
        view = [String]()
        let viewArray = json["view"].arrayValue
        for viewJson in viewArray{
            view.append(viewJson.stringValue)
        }
    }

    @objc required init(coder aDecoder: NSCoder) {
        data = aDecoder.decodeObject(forKey: "data") as? [Data]
        view = aDecoder.decodeObject(forKey: "view") as? [String]
    }
    
    func encode(with aCoder: NSCoder) {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if view != nil{
            aCoder.encode(view, forKey: "view")
        }
    }
}

class Data : NSObject, NSCoding {
    
    var data : Datas!
    var name : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let dataJson = json["data"]
        if !dataJson.isEmpty{
            data = Datas(fromJson: dataJson)
        }
        name = json["name"].stringValue
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        data = aDecoder.decodeObject(forKey: "data") as? Datas
        name = aDecoder.decodeObject(forKey: "name") as? String
    }

    func encode(with aCoder: NSCoder) {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
    }
}

class Datas : NSObject, NSCoding{

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

    @objc required init(coder aDecoder: NSCoder) {
        selectedId = aDecoder.decodeObject(forKey: "selectedId") as? Int
        variants = aDecoder.decodeObject(forKey: "variants") as? [dataVariant]
    }

    func encode(with aCoder: NSCoder) {
        if selectedId != nil{
            aCoder.encode(selectedId, forKey: "selectedId")
        }
        if variants != nil{
            aCoder.encode(variants, forKey: "variants")
        }
    }
}

class dataVariant : NSObject, NSCoding {

    var id : Int!
    var text : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        text = json["text"].stringValue
    }

    @objc required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        text = aDecoder.decodeObject(forKey: "text") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if text != nil {
            aCoder.encode(text, forKey: "text")
        }
    }
}




//struct test: Codable {
//    var view: [String]?
//    var data: [Data]
//
//}
//struct Data: Codable {
//    var name: String
//    var data: data?
//}
//struct data: Codable {
//    var url: String?
//    var text: String?
//    var selectedId: Int?
//    var variants: [variants]?
//}
//struct variants: Codable {
//    var id: Int!
//    var text: String!
//}

