//
//  CountdownTimer.swift
//  Mybyk
//
//  Created by Parth Kapadia on 22/06/21.
//

import Foundation

class CountdownTimer {
    
    static let sharedInstace = CountdownTimer()
    
    var timer : Timer?
    var handler: (()->Void)?
    
    private init() {
        
    }
    
    func start() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                self?.handler?()
            })
        }
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
}
