//
//  ContentView.swift
//  APAssignment
//
//  Created by Amit Arya iOS Dev on 17/12/25.
//

import SwiftUI

struct ContentView: View {
    
    private let baseURL = APIConstants.baseURL
    @ObservedObject var vm = ImagesViewModel.shared
    
    let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.imageModels, id: \.id){ imageModel in
                    CustomImageView(imageModel: imageModel)
                }
            }
        }
        .onAppear {
            vm.getImageModels(from: baseURL)
        }
        .alert(isPresented:
                Binding(get: { vm.errorMessage != nil},
                        set: { _ in vm.errorMessage = nil}),
               content: {
            Alert(title: Text("Alert"), message: Text(vm.errorMessage ?? ""), dismissButton: .default(Text("Ok")))
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
