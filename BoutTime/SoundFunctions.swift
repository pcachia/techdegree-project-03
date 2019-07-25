//
//  SoundFunctions.swift
//  BoutTime
//
//  Created by Phil Cachia on 5/29/19.
//  Copyright © 2019 Phil Cachia. All rights reserved.
//

import UIKit
import GameKit

// SOUNDS
// <--

class SoundManager {

    var gameSoundQuestionCorrect: SystemSoundID = 0
    var gameSoundQuestionWrong: SystemSoundID = 1

    // function to load question correct sound
    func loadGameQuestionCorrectSound() {
        let path = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundQuestionCorrect)
    }

    // function to start sound when game starts
    func playQuestionCorrectSound() {
        AudioServicesPlaySystemSound(gameSoundQuestionCorrect)
    }

    // function to load question wrong sound
    func loadGameQuestionWrongSound() {
        let path = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSoundQuestionWrong)
    }

    // function to start sound when game starts
    func playQuestionWrongSound() {
        AudioServicesPlaySystemSound(gameSoundQuestionWrong)
    }

}
// -->
