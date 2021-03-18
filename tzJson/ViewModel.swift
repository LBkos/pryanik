import Foundation
import SwiftyJSON
import Alamofire
import Combine

class ViewModel: ObservableObject {
    
    
    @Published var dataView: datamodel?
    @Published var view: [String]?
    @Published var data: [dataDatum]?
    @Published var text = ""
    @Published var textImage = ""
    @Published var url: URL?
    @Published var selectedId: Int?
    @Published var variants : [dataVariant]!

    var bag = Set<AnyCancellable>()
    
    func getDataApi() {
        //request data
         AF.request("https://pryaniky.com/static/json/sample.json").publishData()
            //.receive(on: RunLoop.main)
            //.debounce(for: 0.5, scheduler: RunLoop.main)
            .sink( receiveValue: { [self](value) in
                switch value.result {
                case .success(let data):
                    let json = JSON(data)
                    self.dataView = datamodel(fromJson: json)
                    view = dataView?.view
                    for item in (dataView?.data) ?? [] {
                        switch item.name {
                        case "hz":
                            text = item.data.text ?? ""
                        case "picture":
                            textImage = item.data.text ?? ""
                            url = URL(string: item.data.url ?? "")
                        case "selector":
                            selectedId = item.data.selectedId
                            variants = item.data.variants
                        default:
                            break
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            .store(in: &bag)
        

    }
    var canceleble: AnyCancellable? = nil
    
    
    init() {
        getDataApi()
        
    }
    
   
}
