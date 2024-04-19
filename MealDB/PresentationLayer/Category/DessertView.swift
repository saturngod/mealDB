//
//  ContentView.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import SwiftUI

struct DessertView: View {
    @ObservedObject var viewModel: DessertViewModel = DessertViewModel()
    
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .error(let error):
                Text("Sorry! There is issue")
                Text(error.localizedDescription)
            case .loading:
                Text("Loading...")
            case .idle:
                Text("ready")
            }
        }
        .padding()
    }
}

#Preview {
    DessertView()
}
