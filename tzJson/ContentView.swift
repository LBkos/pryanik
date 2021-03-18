//
//  ContentView.swift
//  tzJson
//
//  Created by Константин Лопаткин on 29.01.2021.
//

import SwiftUI
import URLImage

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var txt = ""
    @State var img = ""
    
    var body: some View {
        VStack {
            List(viewModel.view ?? [], id: \.self) { item in
                switch item {
                case "hz":
                    Text(txt).onTapGesture { self.txt = "" }
                    Text(viewModel.text)
                        .onTapGesture { self.txt = item }
                    
                case "picture":
                    Text(img).onTapGesture { img = "" }
                    URLImage(url: viewModel.url! , content: { image in
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                    }).onTapGesture { img = viewModel.textImage }
                case "selector":
                    Text("\(viewModel.selectedId ?? 0)")
                    Picker(selection: $viewModel.selectedId, label: Text("eht")) {
                        ForEach(viewModel.variants ?? [], id: \.id){ i in
                            Text("\(i.text)").tag(1)
                        }
                    }
                    
                default:
                    Text("")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

