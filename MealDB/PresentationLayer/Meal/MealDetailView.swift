//
//  MealDetailView.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import SwiftUI
import NukeUI

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
                        ScrollView {
                            VStack {
                                mealDetailHeader
                                instructionBody
                                instructionList
                                Text("\(viewModel.ingredientsArray.count)")
                            }
                            .padding()
                        }
                        
                    }
                }
                
            }
            .navigationTitle(viewModel.mealDetail?.strMeal ?? "")
            .navigationBarTitleDisplayMode(.inline)
               
        
        .onAppear {
            Task {
                await viewModel.loadDetail(mealId:mealId)
            }
        }
    }
    
    var mealDetailHeader: some View {
        HStack {
            LazyImage(url: URL(string: viewModel.mealDetail?.strMealThumb ?? ""))
                .processors([.resize(width:30)])
            Text(viewModel.mealDetail?.strMeal ?? "N/A")
            Spacer()
        }
    }
    
    var instructionBody: some View {
        Text(viewModel.mealDetail?.strInstructions ?? "")
    }
    
    var instructionList: some View {
        VStack {
            
            ForEach(viewModel.ingredientsArray,id:\.self) { integredient in
                HStack {
                    Text(integredient.ingredient)
                    Text("|")
                    Text(integredient.measurement)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        MealDetailView(mealId: "53049")
    }
}
