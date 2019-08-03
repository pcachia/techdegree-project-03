// Team Tree House
// Swift tech degree project 03 - 2nd try
// Going for EXCEED EXPECTATIONS mark - PLEASE FAIL ME IF THIS PROJECT DOES NOT EXCEED EXPECTATIONS
// ALSO IF THIS PROJECT IS NOT UP TO STANDARD FOR AN EMPLOYMENT SITUATION, PLEASE FAIL ME AS WELL.
// I have struggled alot to complete this project but I want also to improve, so if you may have for me a better advice how I should revise my project and make it better, please feel free to fail me - if I may have an advice of what I should revise, it is kindly appreciated. Thank you in advance.
//
//  ViewController.swift
//  BoutTime
//
//  Created by Phil Cachia on 5/27/19.
//  Copyright © 2019 Phil Cachia. All rights reserved.
//

import UIKit
// framework to e able to open safari
import SafariServices

// To dismiss the Safari View Controller the View Controller needs to conform to the SFSafariViewControllerDelegate
class ViewController: UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label02: UILabel!
    @IBOutlet weak var label03: UILabel!
    @IBOutlet weak var label04: UILabel!
    @IBOutlet weak var nextRound: UIButton!
    @IBOutlet weak var downButton1: UIButton!
    @IBOutlet weak var upButton2: UIButton!
    @IBOutlet weak var downButton2: UIButton!
    @IBOutlet weak var upButton3: UIButton!
    @IBOutlet weak var downButton3: UIButton!
    @IBOutlet weak var upButton4: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stackViewArrowButtons: UIStackView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // spacing zero in between of the smaller buttons
        stackViewArrowButtons.setCustomSpacing(0.0, after: upButton2)
        stackViewArrowButtons.setCustomSpacing(0.0, after: upButton3)

        // load sounds
        sound.loadGameQuestionCorrectSound()
        sound.loadGameQuestionWrongSound()
        
        // start game
        playAgain()
    }
    // VARIALES TO MANAGE GAME -->
    // get sound manager instance
    var sound = SoundManager()
    
    // multi dimensional array to contain all existing events questions[ID, String]
    var allExistingEvents = [Int: String]()
    // multi dimensional array to contain all generated rounds[questions[ID, String]]
    var allEventsRandomQuestions = [[Event]]()
    // multi dimensional array to contain all generated rounds[questions[ID, String]] in the correct order (to compare after each round)
    var allEventsCorrectQuestions = [[Event]]()

    // array to contain the round answers in the correct sequence to compare if the user have sorted the lables correctly
    var roundAswers = [Event]()
    //  array to contain all user answered rounds[questions[ID, String]]
    var roundAnsweredQuestions = [Int]()
    //  array to contain all user answered rounds weblinks
    var roundAnsweredQuestionsLinks = [String]()

    // variable to manage the game round number
    var round: Int = 0
    // variable that will hold the number of correct rounds in a gamme
    var correctRounds: Int = 0
    //<--
    
    
    // TIMER -->
    // Variable that will hold a starting value of round seconds.
    var seconds: Int = 60
    // variable to store the timer instance
    var timer = Timer()
    // This will be used to make sure only one timer is created at a time.
    var isTimerRunning = false
    // function to start to run timer, function updateTimer() trigers every second
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    // function to update timer
    @objc func updateTimer() {
        // Decrements (count down) the seconds.
        seconds -= 1
        // if seconds is 0:
            // update TimerLabel.text with current seconds
            // stop timer
            // indicate that timer is currently not running
            // hide all arrow buttons
            // check if round answers if they are correct
        // else :
            // update TimerLabel.text with current seconds
        if seconds == 0 {
            timerLabel.text = String(seconds)
            timer.invalidate()
            isTimerRunning = false
            hideArrowButtons()
            checkAnswers()
        } else {
            timerLabel.text = String(seconds)
        }
    }
    // function to reset timer
    func resetTimer() {
        // reset seconds
        seconds = 60
        // update timer label with start seconds
        timerLabel.text = String(seconds)
        // update round by incrementing it
        round += 1
        // run timer
        timer = Timer()
        // set timer is running to true
        isTimerRunning = true
    }
    //<--

    
    //--> INGAME FUNCTIONS
    // function that swaps the text value of two labels
    func swapValues(labelA: UILabel, labelB: UILabel) {
        let labelAText = labelA.text
        let labelBText = labelB.text
        labelA.text = labelBText
        labelB.text = labelAText
    }
    // function to check game answers
    func checkAnswers() {
        // get order of user answered questions
        let answeredQuestions = [label01.text, label02.text, label03.text, label04.text]
        // get all events
        let events = allExistingEvents
        // store keys for later use in web
        for answeredQuestion in answeredQuestions {
            for event in events {
                if answeredQuestion == event.value {
                    roundAnsweredQuestions.append(event.key)
                }
            }
        }
        // getting the current events array
        let eventKeys = roundAnsweredQuestions
        // declaring empty array to store url links
        var urlLinks: [String] = []
        // loop current events keys to get url links eventsWebLinksArray[event.eventKey]
        for event in eventKeys {
            // appending url string to url links array
            urlLinks.append(eventsWebLinksArray[event - 1])
        }
        // copy link to roundAnsweredQuestionsLinks, to use for safari browser
        roundAnsweredQuestionsLinks = urlLinks
        // if first label order is correct, turn label text to green
        // else turn label text to red
        if label01.text == roundAswers[0].eventDescription {
            label01.textColor = UIColor.green
        } else {
            label01.textColor = UIColor.red
        }
        // if second label order is correct, turn label text to green
        // else turn label text to red
        if label02.text == roundAswers[1].eventDescription {
            label02.textColor = UIColor.green
        } else {
            label02.textColor = UIColor.red
        }
        // if third label order is correct, turn label text to green
        // else turn label text to red
        if label03.text == roundAswers[2].eventDescription {
            label03.textColor = UIColor.green
        } else {
            label03.textColor = UIColor.red
        }
        // if fourth label order is correct, turn label text to green
        // else turn label text to red
        if label04.text == roundAswers[3].eventDescription {
            label04.textColor = UIColor.green
        } else {
            label04.textColor = UIColor.red
        }
        // if all labels order are correct:
            // update text
            // play correct sound
            // show correct button
            // increment correct rounds variable
        // else:
            // update text
            // play incorrect sound
            // show incorrect button
        if label01.text == roundAswers[0].eventDescription &&
            label02.text == roundAswers[1].eventDescription &&
            label03.text == roundAswers[2].eventDescription &&
            label04.text == roundAswers[3].eventDescription {
            sound.playQuestionCorrectSound()
            nextRound.setImage(UIImage(named: "next_round_success.png"), for: UIControl.State.normal)
            correctRounds += 1
        } else {
            sound.playQuestionWrongSound()
            nextRound.setImage(UIImage(named: "next_round_fail.png"), for: UIControl.State.normal)
        }
        // show NextRound button
        nextRound.isHidden = false
        // remove all timer label text
        timerLabel.text = "";
        // Enable web links
        webLinksLabelsEnable()
        // change info label text
        infoLabel.text = "Tap events to learn more"
    }
    // function used to update labels for the next round
    func updateRound() {
        // empty answered events array
        roundAnsweredQuestions = []
        // reset all labels to black color
        label01.textColor = UIColor.black
        label02.textColor = UIColor.black
        label03.textColor = UIColor.black
        label04.textColor = UIColor.black
        // assigning all labels an event for current round
        label01.text = allEventsRandomQuestions[round][0].eventDescription
        label02.text = allEventsRandomQuestions[round][1].eventDescription
        label03.text = allEventsRandomQuestions[round][2].eventDescription
        label04.text = allEventsRandomQuestions[round][3].eventDescription
        // updating correct answers array for round
        roundAswers = allEventsCorrectQuestions[round]
        // disable weblinks
        webLinksLabelsDisable()
        // updating info button
        infoLabel.text = "Shake to complete";
    }
    // function to show all game buttons
    func showGameButtons() {
        label01.isHidden = false
        label02.isHidden = false
        label03.isHidden = false
        label04.isHidden = false
        downButton1.isHidden = false
        downButton2.isHidden = false
        downButton3.isHidden = false
        upButton2.isHidden = false
        upButton3.isHidden = false
        upButton4.isHidden = false
    }
    // function to hide all game buttons
    func hideGameButtons() {
        label01.isHidden = true
        label02.isHidden = true
        label03.isHidden = true
        label04.isHidden = true
        downButton1.isHidden = true
        downButton2.isHidden = true
        downButton3.isHidden = true
        upButton2.isHidden = true
        upButton3.isHidden = true
        upButton4.isHidden = true
    }
    // function to show all arrow buttons
    func showArrowButtons() {
        downButton1.isHidden = false
        downButton2.isHidden = false
        downButton3.isHidden = false
        upButton2.isHidden = false
        upButton3.isHidden = false
        upButton4.isHidden = false
    }
    // function to hide all arrow buttons
    func hideArrowButtons() {
        downButton1.isHidden = true
        downButton2.isHidden = true
        downButton3.isHidden = true
        upButton2.isHidden = true
        upButton3.isHidden = true
        upButton4.isHidden = true
    }
    //<--

    
    // --> NEW GAME
    // function to start a new game
    func playAgain() {
        // set round to 0
        round = 0
        // get the game instance and store it into the game constant
        let game = GameManager()
        // pass all events into array, (will use for weblinks)
        allExistingEvents = game.eventsArray
        // loads all events
        game.injectEvents()
        // distributing the picked up events
        game.distriubtePickedUpEvents()
        
        // hiding the next round button
        nextRound.isHidden = true
        
        // get all rounds questions in array
        allEventsRandomQuestions = game.roundsEvents
        
        // get all solved rounds questions in array
        allEventsCorrectQuestions = game.roundsEventsAnswers

        // prepareing round
        updateRound()
        // run timer
        runTimer()
    }
    // <--


    // --> Web Functions
    // credit https://riptutorial.com/ios/example/9263/clickable-label
    // function to enable labels to be tabed
    func webLinksLabelsEnable() {
        label01.isUserInteractionEnabled = true
        label02.isUserInteractionEnabled = true
        label03.isUserInteractionEnabled = true
        label04.isUserInteractionEnabled = true
        // attach gestures for making labels tabing enabled
        let gestureURLLabel01 = UITapGestureRecognizer(target: self, action: #selector(ViewController.getURLLinkLabel01))
        label01.addGestureRecognizer(gestureURLLabel01)
        let gestureURLLabel02 = UITapGestureRecognizer(target: self, action: #selector(ViewController.getURLLinkLabel02))
        label02.addGestureRecognizer(gestureURLLabel02)
        let gestureURLLabel03 = UITapGestureRecognizer(target: self, action: #selector(ViewController.getURLLinkLabel03))
        label03.addGestureRecognizer(gestureURLLabel03)
        let gestureURLLabel04 = UITapGestureRecognizer(target: self, action: #selector(ViewController.getURLLinkLabel04))
        label04.addGestureRecognizer(gestureURLLabel04)
    }
    // function to disable labels to be tabed
    func webLinksLabelsDisable() {
        label01.isUserInteractionEnabled = false
        label02.isUserInteractionEnabled = false
        label03.isUserInteractionEnabled = false
        label04.isUserInteractionEnabled = false
    }
    // setting url delegation to safari to label 01
    @objc func getURLLinkLabel01() {
        // redirecting label01 to it's link
        let urlLink = roundAnsweredQuestionsLinks[0]
        // check if website exists
        guard let url = URL(string: urlLink) else {
            return
        }
        // getting additional setting before opening browser
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        // openURL Action method
        safariVC.delegate = self
    }
    // setting url delegation to safari to label 02
    @objc func getURLLinkLabel02() {
        // redirecting label02 to it's link
        let urlLink = roundAnsweredQuestionsLinks[1]
        // check if website exists
        guard let url = URL(string: urlLink) else {
            return
        }
        // getting additional setting before opening browser
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        // openURL Action method
        safariVC.delegate = self
    }
    // setting url delegation to safari to label 03
    @objc func getURLLinkLabel03() {
        // redirecting label01 to it's link
        let urlLink = roundAnsweredQuestionsLinks[2]
        // check if website exists
        guard let url = URL(string: urlLink) else {
            return
        }
        // getting additional setting before opening browser
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        // openURL Action method
        safariVC.delegate = self
    }
    // setting url delegation to safari to label 04
    @objc func getURLLinkLabel04() {
        // redirecting label01 to it's link
        let urlLink = roundAnsweredQuestionsLinks[3]
        // check if website exists
        guard let url = URL(string: urlLink) else {
            return
        }
        // getting additional setting before opening browser
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        // openURL Action method
        safariVC.delegate = self
    }
    // delegate method for all labels
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    //<--

    
    // --> GAME ACTIONS
    // functions that trigger an end of round bby shaking the device
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            timerLabel.text = String(seconds)
            timer.invalidate()
            isTimerRunning = false
            hideArrowButtons()
            checkAnswers()
        }
    }

    // arrow buttons to run functions to swap label values
    @IBAction func DownButtonTo2(_ sender: Any) {
        swapValues(labelA: label01, labelB: label02)
    }
    @IBAction func UpButtonTo1(_ sender: Any) {
        swapValues(labelA: label01, labelB: label02)
    }
    @IBAction func DownButtonTo3(_ sender: Any) {
        swapValues(labelA: label02, labelB: label03)
    }
    @IBAction func UpButtonTo2(_ sender: Any) {
        swapValues(labelA: label02, labelB: label03)
    }
    @IBAction func DownButtonTo4(_ sender: Any) {
        swapValues(labelA: label03, labelB: label04)
    }
    @IBAction func UpButtonTo3(_ sender: Any) {
        swapValues(labelA: label03, labelB: label04)
    }
    
    // functions to change arrow buttons appearance on touch down, and again on touch up
    @IBAction func DownButtonTo2TouchDown(_ sender: Any) {
        downButton1.setImage(UIImage(named: "down_full_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo2TouchUp(_ sender: Any) {
        downButton1.setImage(UIImage(named: "down_full.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo1TouchDown(_ sender: Any) {
        upButton2.setImage(UIImage(named: "up_half_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo1TouchUp(_ sender: Any) {
        upButton2.setImage(UIImage(named: "up_half.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo3TouchDown(_ sender: Any) {
        downButton2.setImage(UIImage(named: "down_full_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo3TouchUp(_ sender: Any) {
        downButton2.setImage(UIImage(named: "down_full.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo2TouchDown(_ sender: Any) {
        upButton3.setImage(UIImage(named: "up_half_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo2TouchUp(_ sender: Any) {
        upButton3.setImage(UIImage(named: "up_half.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo4TouchDown(_ sender: Any) {
        downButton3.setImage(UIImage(named: "down_half_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo4TouchUp(_ sender: Any) {
        downButton3.setImage(UIImage(named: "down_half.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo3TouchDown(_ sender: Any) {
        upButton4.setImage(UIImage(named: "up_full_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo3TouchUp(_ sender: Any) {
        upButton4.setImage(UIImage(named: "up_full.png"), for: UIControl.State.normal)
    }
    
    // Next Round button
    @IBAction func NextRoundButton(_ sender: Any) {
        // reset the timer
        resetTimer()
        // if round is set to 0: START GAME
            // set font to big
            // show game buttons
            // show info label
            // start game
        // else if round is set to 6: END GAME
            // hide game buttons
            // hide info label
            // set font to small
            // show game results
            // set round to -1
            // reset correct rounds
            // set button image on NextRound Button to play again
        // else : GO TO NEXT ROUND
            // update round events questions
            // show arrow buttons
            // run timer
            // hide NextRound button
        if round == 0 {
            timerLabel.font = UIFont.systemFont(ofSize: 50)
            showGameButtons()
            infoLabel.isHidden = false
            playAgain()
        } else if round == 6 {
            hideGameButtons()
            infoLabel.isHidden = true
            timerLabel.font = UIFont.systemFont(ofSize: 40)
            timerLabel.text = "Your score \(String(correctRounds))/\(String(round))"
            round = -1
            correctRounds = 0
            nextRound.setImage(UIImage(named: "play_again.png"), for: UIControl.State.normal)
        } else {
            updateRound()
            showArrowButtons()
            runTimer()
            nextRound.isHidden = true
        }
    }
    //<--
    
}

