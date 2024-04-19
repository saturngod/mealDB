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
        NavigationView {
            VStack {
                switch viewModel.viewState {
                case .error(let error):
                    Text("Sorry! There is issue")
                    Text(error.localizedDescription)
                case .loading:
                    ProgressView()
                        .controlSize(.large)
                case .idle:
                    dessertList
                }
            }
            .onAppear(perform: {
                Task {
                    await viewModel.loadMeals()
                }
            })
            .navigationTitle("Dessert")
        }
    }
    
    var dessertList: some View {
        List {
            
            ForEach(viewModel.meals,id:\.idMeal) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal), label: {
                    MealViewCell(meal: meal)
                })
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    DessertView()
}
