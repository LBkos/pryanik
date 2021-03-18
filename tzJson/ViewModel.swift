import Foundation
import SwiftyJSON
import Alamofire
import Combine

class ViewModel: ObservableObject {
    
    @Published var dataView: DataModel?
    @Published var view: [String]?
    @Published var data: [Data]?
    @Published var text = ""
    @Published var textImage = ""
    @Published var url: URL?
    @Published var selectedId: Int?
    @Published var variants : [dataVariant]!
    
    private var cancellable: AnyCancellable? = nil
    private var bag = Set<AnyCancellable>()
    
    init() {
        getDataApi()
    }
    
    func getDataApi() {
        //request data
        AF.request("https://pryaniky.com/static/json/sample.json").publishData()
            .sink( receiveValue: { [self](value) in
                switch value.result {
                case .success(let data):
                    let json = JSON(data)
                    self.dataView = DataModel(fromJson: json)
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
    
    //    func getData() -> AnyPublisher<test, Error> {
    //        let url = URL(string: "https://pryaniky.com/static/json/sample.json")
    //        return URLSession.shared.dataTaskPublisher(for: url!)
    //            .map { $0.data }
    //            .decode(type: test.self, decoder: JSONDecoder())
    //            .receive(on: RunLoop.main)
    //            .eraseToAnyPublisher()
    //    }
    //    func getUsers() {
    //       cancellable = getData().sink(receiveCompletion: { (_) in
    //
    //        }, receiveValue: { item in
    //            self.dat = item
    //            print(self.dat!)
    //
    //        })
    //
    //        }
    
}
