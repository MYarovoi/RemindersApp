//
//  Delay.swift
//  ReminderApp
//
//  Created by Никита Яровой on 24.03.2025.
//

import Foundation

class Delay {
    var seconds: Double
    var workItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
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
