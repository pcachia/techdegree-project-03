//
//  GameFunctions.swift
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

// Event struct, contains an integer and a string
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
        1: "The first live transcontinental television broadcast takes place in San Francisco",
        2: "The U.S. becomes a member of the Southeast Asia Treaty Organization",
        3: "The Dow Jones Industrial Average closes at an all-time high of 382.74,",
        4: "NBC airs The Tonight Show, the first late-night talk show.",
        5: "Disneyland opens at Anaheim, California",
        6: "Rock and roll music enters the mainstream",
        7: "Elvis Presley appears on The Ed Sullivan Show for the first time.",
        8: "In God We Trust, adopted as national motto",
        9: "NASA formed as the U.S. begins ramping up efforts to explore space",
        10: "Alaska and Hawaii became the 49th and 50th U.S. states",
        11: "Author Harper Lee publishes To Kill A Mockingbird",
        12: "John F. Kennedy becomes the 35th President, Johnson, Vice President",
        13: "Peace Corps established",
        14: "Alan Shepard pilots the Freedom 7 capsule to become the first American in space",
        15: "Atomic Test Ban Treaty",
        16: "The Beatles arrive in the U.S.",
        17: "Voting Rights Act",
        18: "The first Super Bowl is played",
        19: "Apollo 8 and its three-astronaut crew orbit the Moon",
        20: "Sesame Street premieres on National Educational Television",
        21: "The first Earth Day is observed",
        22: "American Top 40, hosted by radio",
        23: "Apollo 17 flies to the Moon",
        24: "Skylab is launched as the USA's first space station",
        25: "Sweet Home Alabama released by Lynyrd Skynyrd",
        26: "The movie Jaws is released",
        27: "Bill Gates founds Microsoft",
        28: "The Apollo–Soyuz Test Project begins",
        29: "Sony's Betamax becomes the first commercially successful home video recording unit",
        30: "Steve Jobs, Steve Wozniak, and Ronald Wayne found Apple Inc",
        31: "The television miniseries Roots airs on ABC",
        32: "The Atari 2600 becomes the first successful home video game system",
        33: "Ronald Reagan is elected president",
        34: "MTV signs on",
        35: "Chrysler unveils its minivans",
        36: "The Fox Broadcasting Company launched",
        37: "The animated comedy The Simpsons debuts",
        38: "Hubble Space Telescope launched",
        39: "The World Wide Web publicly debuts as an Internet service.",
        40: "The Dow Jones Industrial Average closes above the 10,000 mark for the first time"
    ]
    // array that will store the randomly picked up events
    var events: [Event] = []
    
    // loads all events from eventsArray array, and passed them into events array conforming the Event Struct
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
    
    // event rounds multi-dimensional arrays
    var round01: [Event] = []
    var round02: [Event] = []
    var round03: [Event] = []
    var round04: [Event] = []
    var round05: [Event] = []
    var round06: [Event] = []
    
    // correct answers event rounds multi-dimensional arrays
    var round01Answers: [Event] = []
    var round02Answers: [Event] = []
    var round03Answers: [Event] = []
    var round04Answers: [Event] = []
    var round05Answers: [Event] = []
    var round06Answers: [Event] = []

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
            ()
        }
    }
    
    // function to solve all rounds 
    func solveRoundAnswers() {
        // getting the answers for all rounds
        round01Answers = round01
        round02Answers = round02
        round03Answers = round03
        round04Answers = round04
        round05Answers = round05
        round06Answers = round06
        round01Answers.sort { $0.eventKey < $1.eventKey }
        round02Answers.sort { $0.eventKey < $1.eventKey }
        round03Answers.sort { $0.eventKey < $1.eventKey }
        round04Answers.sort { $0.eventKey < $1.eventKey }
        round05Answers.sort { $0.eventKey < $1.eventKey }
        round06Answers.sort { $0.eventKey < $1.eventKey }
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
