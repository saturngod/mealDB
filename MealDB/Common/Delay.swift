//
//  Delay.swift
//  MealDB
//
//  Created by Htain Lin Shwe on 19/04/2024.
//

import Foundation

class Delay {
    private var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 1.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel() {
        workItem?.cancel()
    }
}
