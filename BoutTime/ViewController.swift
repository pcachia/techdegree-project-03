// Team Tree House
// Swift tech degree project 03
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
    @IBOutlet weak var Label01: UILabel!
    @IBOutlet weak var Label02: UILabel!
    @IBOutlet weak var Label03: UILabel!
    @IBOutlet weak var Label04: UILabel!
    @IBOutlet weak var NextRound: UIButton!
    @IBOutlet weak var DownButton1: UIButton!
    @IBOutlet weak var UpButton2: UIButton!
    @IBOutlet weak var DownButton2: UIButton!
    @IBOutlet weak var UpButton3: UIButton!
    @IBOutlet weak var DownButton3: UIButton!
    @IBOutlet weak var UpButton4: UIButton!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var BrowserLinkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load sounds
        sound.loadGameQuestionCorrectSound()
        sound.loadGameQuestionWrongSound()
        
        // start game
        playAgain()
    }

    // VARIALES TO MANAGE GAME -->
    // get sound manager instance
    var sound = SoundManager()
    
    // multi dimensional array to contain all generated rounds[questions[ID, String]]
    var allEventsRandomQuestions = [[Event]]()
    // multi dimensional array to contain all generated rounds[questions[ID, String]] in the correct order (to compare after each round)
    var allEventsCorrectQuestions = [[Event]]()

    // array to contain the round answers in the correct sequence to compare if the user have sorted the lables correctly
    var roundAswers = [Event]()

    // variable to manage the game round number
    var round: Int = 0
    // variable that will hold the number of correct rounds in a gamme
    var correctRounds: Int = 0
    //<--
    
    
    // TIMER -->
    // Variable that will hold a starting value of round seconds.
    var seconds: Int = 3
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
            TimerLabel.text = String(seconds)
            timer.invalidate()
            isTimerRunning = false
            hideArrowButtons()
            checkAnswers()
        } else {
            TimerLabel.text = String(seconds)
        }
    }
    // function to reset timer
    func resetTimer() {
        // reset seconds
        seconds = 3
        // update timer label with start seconds
        TimerLabel.text = String(seconds)
        // update round by incrementing it
        round += 1
        // run timer
        timer = Timer()
        // set timer is running to true
        isTimerRunning = true
    }
    //<--

    
    //--> INGAME FUNCTIONS
    // functions to swap label values for arrow buttons
    // function that swaps the text value of label 1 and 2
    func swap1With2() {
        let label01Text = Label01.text
        let label02Text = Label02.text
        Label01.text = label02Text
        Label02.text = label01Text
    }
    // function that swaps the text value of label 2 and 3
    func swap2With3() {
        let label02Text = Label02.text
        let label03Text = Label03.text
        Label02.text = label03Text
        Label03.text = label02Text
    }
    // function that swaps the text value of label 3 and 4
    func swap3With4() {
        let label03Text = Label03.text
        let label04Text = Label04.text
        Label03.text = label04Text
        Label04.text = label03Text
    }
    // function to check game answers
    func checkAnswers() {
        // if first label order is correct, turn label text to green
        // else turn label text to red
        if Label01.text == roundAswers[0].eventDescription {
            Label01.textColor = UIColor.green
        } else {
            Label01.textColor = UIColor.red
        }
        // if second label order is correct, turn label text to green
        // else turn label text to red
        if Label02.text == roundAswers[1].eventDescription {
            Label02.textColor = UIColor.green
        } else {
            Label02.textColor = UIColor.red
        }
        // if third label order is correct, turn label text to green
        // else turn label text to red
        if Label03.text == roundAswers[2].eventDescription {
            Label03.textColor = UIColor.green
        } else {
            Label03.textColor = UIColor.red
        }
        // if fourth label order is correct, turn label text to green
        // else turn label text to red
        if Label04.text == roundAswers[3].eventDescription {
            Label04.textColor = UIColor.green
        } else {
            Label04.textColor = UIColor.red
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
        if Label01.text == roundAswers[0].eventDescription &&
            Label02.text == roundAswers[1].eventDescription &&
            Label03.text == roundAswers[2].eventDescription &&
            Label04.text == roundAswers[3].eventDescription {
            TimerLabel.text = "Well Done, the order is correct!";
            sound.playQuestionCorrectSound()
            NextRound.setImage(UIImage(named: "next_round_success.png"), for: UIControl.State.normal)
            correctRounds += 1
        } else {
            TimerLabel.text = "Sorry, the order is incorrect!";
            sound.playQuestionWrongSound()
            NextRound.setImage(UIImage(named: "next_round_fail.png"), for: UIControl.State.normal)
        }
        // show NextRound button
        NextRound.isHidden = false
    }
    // function used to update labels for the next round
    func updateRound() {
        // reset all labels to black color
        Label01.textColor = UIColor.black
        Label02.textColor = UIColor.black
        Label03.textColor = UIColor.black
        Label04.textColor = UIColor.black
        // assigning all labels an event for current round
        Label01.text = allEventsRandomQuestions[round][0].eventDescription
        Label02.text = allEventsRandomQuestions[round][1].eventDescription
        Label03.text = allEventsRandomQuestions[round][2].eventDescription
        Label04.text = allEventsRandomQuestions[round][3].eventDescription
        // updating correct answers array for round
        roundAswers = allEventsCorrectQuestions[round]
        // updating link button text
        BrowserLinkButton.setTitle("Read more", for: .normal)
    }
    // function to show all game buttons
    func showGameButtons() {
        Label01.isHidden = false
        Label02.isHidden = false
        Label03.isHidden = false
        Label04.isHidden = false
        BrowserLinkButton.isHidden = false
        DownButton1.isHidden = false
        DownButton2.isHidden = false
        DownButton3.isHidden = false
        UpButton2.isHidden = false
        UpButton3.isHidden = false
        UpButton4.isHidden = false
    }
    // function to hide all game buttons
    func hideGameButtons() {
        Label01.isHidden = true
        Label02.isHidden = true
        Label03.isHidden = true
        Label04.isHidden = true
        BrowserLinkButton.isHidden = true
        DownButton1.isHidden = true
        DownButton2.isHidden = true
        DownButton3.isHidden = true
        UpButton2.isHidden = true
        UpButton3.isHidden = true
        UpButton4.isHidden = true
    }
    // function to show all arrow buttons
    func showArrowButtons() {
        BrowserLinkButton.isHidden = true
        DownButton1.isHidden = false
        DownButton2.isHidden = false
        DownButton3.isHidden = false
        UpButton2.isHidden = false
        UpButton3.isHidden = false
        UpButton4.isHidden = false
    }
    // function to hide all arrow buttons
    func hideArrowButtons() {
        BrowserLinkButton.isHidden = false
        DownButton1.isHidden = true
        DownButton2.isHidden = true
        DownButton3.isHidden = true
        UpButton2.isHidden = true
        UpButton3.isHidden = true
        UpButton4.isHidden = true
    }
    //<--

    
    // --> NEW GAME
    // function to start a new game
    func playAgain() {
        // set round to 0
        round = 0
        // get the game instance and store it into the game constant
        let game = GameManager()
        // loads all events
        game.injectEvents()
        // distributing the picked up events
        game.distriubtePickedUpEvents()
        // solve all rounds
        game.solveRoundAnswers()
        
        // hiding the next round button
        NextRound.isHidden = true
        
        // hiding the link button
        BrowserLinkButton.isHidden = true
        
        // get all rounds questions in array
        allEventsRandomQuestions = [
            game.round01,
            game.round02,
            game.round03,
            game.round04,
            game.round05,
            game.round06
        ]
        
        // get all solved rounds questions in array
        allEventsCorrectQuestions = [
            game.round01Answers,
            game.round02Answers,
            game.round03Answers,
            game.round04Answers,
            game.round05Answers,
            game.round06Answers
        ]
        
        // prepareing round
        updateRound()
        // run timer
        runTimer()
    }
    // <--


    // --> Web Functions
    // button for opening the web browser inside app
    @IBAction func openURL(_ sender: Any) {
        
        let urlLink = eventsWebLinksArray[allEventsRandomQuestions[round][0].eventKey - 1]
        
        // check if website exists
        guard let url = URL(string: urlLink) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
        // openURL Action method
        safariVC.delegate = self
    }
    
    // delegate method
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
            TimerLabel.text = String(seconds)
            timer.invalidate()
            isTimerRunning = false
            hideArrowButtons()
            checkAnswers()
        }
    }

    // arrow buttons to run functions to swap label values
    @IBAction func DownButtonTo2(_ sender: Any) {
        swap1With2();
    }
    @IBAction func UpButtonTo1(_ sender: Any) {
        swap1With2();
    }
    @IBAction func DownButtonTo3(_ sender: Any) {
        swap2With3();
    }
    @IBAction func UpButtonTo2(_ sender: Any) {
        swap2With3();
    }
    @IBAction func DownButtonTo4(_ sender: Any) {
        swap3With4();
    }
    @IBAction func UpButtonTo3(_ sender: Any) {
        swap3With4();
    }
    
    // functions to change arrow buttons appearance on touch down, and again on touch up
    @IBAction func DownButtonTo2TouchDown(_ sender: Any) {
        DownButton1.setImage(UIImage(named: "down_full_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo2TouchUp(_ sender: Any) {
        DownButton1.setImage(UIImage(named: "down_full.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo1TouchDown(_ sender: Any) {
        UpButton2.setImage(UIImage(named: "up_half_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo1TouchUp(_ sender: Any) {
        UpButton2.setImage(UIImage(named: "up_half.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo3TouchDown(_ sender: Any) {
        DownButton2.setImage(UIImage(named: "down_full_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo3TouchUp(_ sender: Any) {
        DownButton2.setImage(UIImage(named: "down_full.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo2TouchDown(_ sender: Any) {
        UpButton3.setImage(UIImage(named: "up_half_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo2TouchUp(_ sender: Any) {
        UpButton3.setImage(UIImage(named: "up_half.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo4TouchDown(_ sender: Any) {
        DownButton3.setImage(UIImage(named: "down_half_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func DownButtonTo4TouchUp(_ sender: Any) {
        DownButton3.setImage(UIImage(named: "down_half.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo3TouchDown(_ sender: Any) {
        UpButton4.setImage(UIImage(named: "up_full_selected.png"), for: UIControl.State.normal)
    }
    @IBAction func UpButtonTo3TouchUp(_ sender: Any) {
        UpButton4.setImage(UIImage(named: "up_full.png"), for: UIControl.State.normal)
    }
    
    // Next Round button
    @IBAction func NextRoundButton(_ sender: Any) {
        // reset the timer
        resetTimer()
        // if round is set to 0: START GAME
            // show game buttons
            // start game
        // else if round is set to 6: END GAME
            // hide game buttons
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
            showGameButtons()
            playAgain()
        } else if round == 6 {
            hideGameButtons()
            TimerLabel.text = "You got \(String(correctRounds)) out of \(String(round)) good."
            round = -1
            correctRounds = 0
            NextRound.setImage(UIImage(named: "play_again.png"), for: UIControl.State.normal)
        } else {
            updateRound()
            showArrowButtons()
            runTimer()
            NextRound.isHidden = true
        }
    }
    //<--
    
}

