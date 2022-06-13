//
//  OTPTimerViewModel.swift
//  Mybyk
//
//  Created by Parth Kapadia on 22/06/21.
//

import Foundation

struct OTPSecond : Equatable
{
    let secondsRemaining : Int
    let initialSecondsRemaining : Int
    
}

func ==(lhs: OTPSecond, rhs: OTPSecond) -> Bool
{
    return lhs.initialSecondsRemaining == rhs.initialSecondsRemaining &&
        lhs.secondsRemaining == rhs.secondsRemaining
}

enum OTPState
{
    case timerStarted(OTPSecond)
    case timerStopped(OTPSecond)
}


struct OTPTimerViewModel
{
    let state: OTPState
    let lblText: String
    
    
    init(state: OTPState)
    {
        self.state = state
        
        switch self.state
        {
        case .timerStarted(let data):
            self.lblText = String(data.secondsRemaining)
        case .timerStopped(let data):
            self.lblText = String(data.secondsRemaining)
        }
    }
    
    func buttonTapped() -> OTPTimerViewModel
    {
        switch self.state {
        case .timerStopped(let data):
            let initialAppdata = OTPSecond(secondsRemaining: data.initialSecondsRemaining, initialSecondsRemaining: data.initialSecondsRemaining)
            return OTPTimerViewModel(state: .timerStarted(initialAppdata))
        default:
            return self
        }
    }
    
    func timerStart() -> OTPTimerViewModel {
        
        switch self.state {
        case .timerStarted(let data):
            return OTPTimerViewModel(state: .timerStarted(data))
        default:
            return self
        }
    }
    
    func tick() -> OTPTimerViewModel {
        switch self.state {
        case .timerStarted(let data):
            let currentSecondsRemaining = data.secondsRemaining - 1
            let newAppData = OTPSecond(secondsRemaining: data.secondsRemaining - 1, initialSecondsRemaining: data.initialSecondsRemaining)
            if currentSecondsRemaining > 0 {
                return OTPTimerViewModel(state: .timerStarted(newAppData))
            } else {
                return OTPTimerViewModel(state: .timerStopped(newAppData))
            }
            
        default:
            return self
        }
    }
}
