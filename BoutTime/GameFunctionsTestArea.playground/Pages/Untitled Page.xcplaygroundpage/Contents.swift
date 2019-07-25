//
//  HistoryEventProvider.swift
//  BoutTime
//
//  Created by Phil Cachia on 5/28/19.
//  Copyright © 2019 Phil Cachia. All rights reserved.
//

// import frameworks
// basic apple framework for the app
import Foundation
// framework for picking up a random number
import GameKit

// EventProvider struct, contains an integer and a string
struct Event {
    
    let eventKey: Int
    let eventDescription: String
    
    init(eventKey: Int, eventDescription: String) {
        self.eventKey = eventKey
        self.eventDescription = eventDescription
    }
}

// Game manager class
// this is where all game data and functions will be managed
class GameManager {
    // Events array
    let eventsArray: [Int: String] = [
        1: "A",
        2: "B",
        3: "C",
        4: "D",
        5: "E",
        6: "F",
        7: "G",
        8: "H",
        9: "I",
        10: "J",
        11: "K",
        12: "L",
        13: "M",
        14: "N",
        15: "O",
        16: "P",
        17: "Q",
        18: "R",
        19: "S",
        20: "T",
        21: "U",
        22: "V",
        23: "W",
        24: "X",
        25: "Y",
        26: "Z",
        27: "AA",
        28: "BB",
        29: "CC",
        30: "DD",
        31: "EE",
        32: "FF",
        33: "GG",
        34: "HH",
        35: "II",
        36: "JJ",
        37: "KK",
        38: "LL",
        39: "MM",
        40: "NN"
    ]
    // array that will store the randomly picked up events
    var events: [Event] = []

    // loads all evets from eventsArray array, and passed them into events array conforming the Event Struct
    func injectEvents() {
        for (eventKey, eventDescription) in eventsArray {
            events.append(Event(eventKey: eventKey, eventDescription: eventDescription))
        }
    }
    
    // function to return a random event
    func randomPickupEvent() -> Int {
        let randomPickupEventNumber = GKRandomSource.sharedRandom().nextInt(upperBound: events.count)
        return randomPickupEventNumber
    }

    // array used to store the indexes of the previously picked up questions
    var pickedUpEvents: [Int] = []

    // round events multi-dimensional arrays
    var round01: [Event] = []
    var round02: [Event] = []
    var round03: [Event] = []
    var round04: [Event] = []
    var round05: [Event] = []
    var round06: [Event] = []

    // var to store the total number of events that need to be picked up
    var totalGameEvents: Int = 24

    // function to get a random event that is not picked up yet
    func addToPickedUpEvents() {
        // get a random event
        var indexOfSelectedQuestion = randomPickupEvent()
        // if the event has been alreally picked up, continue to pick up another event until it is not a dupblicate
        while pickedUpEvents.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = randomPickupEvent()
        }
        // add picked up event index to the picked up events index array
        pickedUpEvents.append(indexOfSelectedQuestion)
        // adding to round depending on count
        switch pickedUpEvents.count {
        case 1...4:
            round01.append(events[indexOfSelectedQuestion])
        case 5...8:
            round02.append(events[indexOfSelectedQuestion])
        case 9...12:
            round03.append(events[indexOfSelectedQuestion])
        case 13...16:
            round04.append(events[indexOfSelectedQuestion])
        case 17...20:
            round05.append(events[indexOfSelectedQuestion])
        case 21...24:
            round06.append(events[indexOfSelectedQuestion])
        default:
            false
        }
    }
    
    // function to distribute the picked up events
    func distriubtePickedUpEvents() {
        var x: Int = 0
        while x < totalGameEvents {
            addToPickedUpEvents()
        x += 1
        }
    }
    
}

var newGame = GameManager()
newGame.injectEvents()
newGame.randomPickupEvent()
newGame.distriubtePickedUpEvents()
newGame.round01[0].eventDescription
newGame.round01[0].eventKey

newGame = GameManager()
newGame.round01


