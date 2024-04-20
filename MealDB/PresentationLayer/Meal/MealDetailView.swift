//
//  MealDetailView.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import SwiftUI
import Kingfisher

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
                    ScrollView(showsIndicators: false) {
                        mealDetailHeader
                        instructionBody
                        ingredientList
                    }
                    
                }
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            Task {
                await viewModel.loadDetail(mealId:mealId)
            }
        }
    }
    
    var mealDetailHeader: some View {
        VStack {
            KFImage(URL(string: viewModel.mealDetail?.strMealThumb ?? ""))
                .resizable()
                .scaledToFit()
            
            Text(viewModel.mealDetail?.strMeal ?? "N/A")
                .font(.title)
            Spacer()
        }
        
    }
    
    var instructionBody: some View {
        VStack(alignment: .leading) {
            Text("Instruction")
                .font(.title2)
                .padding(.bottom,8)
            Text(viewModel.mealDetail?.strInstructions ?? "")
                .fontWeight(.light)
        }
        .padding()
    }
    
    var ingredientList: some View {
        GroupBox {
            Text("Ingredient")
                .font(.title2)
                .padding(.bottom,8)
                ForEach(viewModel.ingredientsArray,id:\.self) { integredient in
                    if integredient != viewModel.ingredientsArray.first {
                        Divider().padding(.vertical, 2)
                    }
                    HStack {
                        Text(integredient.ingredient)
                        Spacer()
                        Text(integredient.measurement)
                    }
                }
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

#Preview {
    NavigationView {
        MealDetailView(mealId: "53049")
    }
}
