//: [Previous](@previous)

import Foundation
import UIKit
import GameKit

// TIMER
// timer credits - https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
// <--
struct GameTimer {
    //This variable will hold a starting value of seconds. It could be any amount above 0.
    var seconds: Int = 60
//    var timer = Timer()
    //This will be used to make sure only one timer is created at a time.
    var isTimerRunning = false

//    // starts to run timer
//    func runTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
//    }
    func updateTimer(remainingSeconds: Int) -> Int {
        let remainingSeconds = seconds - 1     //This will decrement(count down)the seconds.
        return remainingSeconds
        //ViewController.TimerLabel.text = String(seconds)
        print(seconds)
    }
}

var newTimer = GameTimer()
newTimer.seconds
newTimer.seconds = newTimer.updateTimer(remainingSeconds: newTimer.seconds)
newTimer.seconds
newTimer.seconds = newTimer.updateTimer(remainingSeconds: newTimer.seconds)
newTimer.seconds
newTimer.seconds = newTimer.updateTimer(remainingSeconds: newTimer.seconds)
newTimer.seconds
