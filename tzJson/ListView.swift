////
////  List.swift
////  tzJson
////
////  Created by Константин Лопаткин on 04.02.2021.
////
//
//import SwiftUI
//
//struct ListView: View {
//    @ObservedObject var model: ViewModel
//    
//    var body: some View {
//        
//        ForEach(model.da, id: \.name) { item in
//            Text(item.name)
//            Text(item.data.name)
//            Text(item.data.text ?? "")
//            if item.name == "picture" {
//                Image(uiImage: model.image!)
//                    .resizable()
//                    .frame(width: 50, height: 50)
//            }
//            if item.name == "selector" {
//                Text("\(item.data.variants[model.selectedId! - 1].id)")
//                Picker(selection: $model.selectedId, label: Text("h")) {
//                    ForEach(item.data.variants, id: \.id){ i in
//                        Text(i.text).tag(i.id)
//                    }
//                }
//            }
//        }
//    }
//
//}
