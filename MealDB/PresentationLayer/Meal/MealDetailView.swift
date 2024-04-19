//
//  MealDetailView.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import SwiftUI

struct MealDetailView: View {
    
    let mealId: String
    @ObservedObject var viewModel: MealDetailViewModel = MealDetailViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.viewState{
            case .loading:
                ProgressView()
                    .controlSize(.large)
                
            case .error(error: let error):
                Text("Oop! something went wrong")
                Text(error.localizedDescription)
            case .idle:
                if viewModel.mealDetail != nil {
                    Text(viewModel.mealDetail?.strMeal ?? "")
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.loadDetail(mealId:mealId)
            }
        }
    }
}

#Preview {
    MealDetailView(mealId: "53049")
}
