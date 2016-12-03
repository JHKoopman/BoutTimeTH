//
//  ViewController.swift
//  BoutTimeTH
//
//  Created by Jari Koopman on 24/11/2016.
//  Copyright © 2016 JarICT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Outlets and variables
    
    @IBOutlet weak var firstOption: UILabel!
    @IBOutlet weak var secondOption: UILabel!
    @IBOutlet weak var thirdOption: UILabel!
    @IBOutlet weak var fourthOption: UILabel!
    @IBOutlet weak var bottomUpButton: UIButton!
    @IBOutlet weak var topDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var thirdUpButton: UIButton!
    @IBOutlet weak var thirdDownButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var explainingLabel: UILabel!
    @IBOutlet var optionViews: [UIView]!
    @IBOutlet var firstTap: UITapGestureRecognizer!
    @IBOutlet var secondTap: UITapGestureRecognizer!
    @IBOutlet var thirdTap: UITapGestureRecognizer!
    @IBOutlet var fourthTap: UITapGestureRecognizer!
    
    var timer: Timer = Timer()
    var time = 0
    var theresTime = true
    var round: Round!
    var roundsPlayed = 0
    var score = 0
    var firstTimeNextRound = true

    //MARK: Start of code
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the base values when the game first starts
        playAgainButton.imageView?.contentMode = .scaleAspectFit
        playAgainButton.isHidden = true
        timerLabel.text = String(60 - time)
        explainingLabel.text = "Sort the programming languages on founding date. Shake to confirm your answer!"
        explainingLabel.numberOfLines = 0
        
        round = setupRound()
        startRound(round: round)
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        //Check if there's still time left, if so, change positions of text, oterwise do nothing
        if theresTime {
            switch sender {
            case bottomUpButton:
                let currentText = fourthOption.text
                let aboveText = thirdOption.text
                fourthOption.text = aboveText
                thirdOption.text = currentText
            case secondUpButton:
                let currentText = secondOption.text
                let aboveText = firstOption.text
                secondOption.text = aboveText
                firstOption.text = currentText
            case thirdUpButton:
                let currentText = thirdOption.text
                let aboveText = secondOption.text
                thirdOption.text = aboveText
                secondOption.text = currentText
            case topDownButton:
                let currentText = firstOption.text
                let belowText = secondOption.text
                firstOption.text = belowText
                secondOption.text = currentText
            case secondDownButton:
                let currentText = secondOption.text
                let belowText = thirdOption.text
                secondOption.text = belowText
                thirdOption.text = currentText
            case thirdDownButton:
                let currentText = thirdOption.text
                let belowText = fourthOption.text
                thirdOption.text = belowText
                fourthOption.text = currentText
            default:
                print("Something went wrong! Oops!")
            }
        }
    }
    
    func startTimer() {
        //Start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        //Update the timer label
        time += 1
        timerLabel.text = String(60 - time)
        
        if time == 60 {
            //TIMES UP! Invalidate the timer and make the round end
            timer.invalidate()
            roundEnd()
        }
    }
    
    func roundEnd() {
        print("ROUND IS OVER!")
        //Disable buttons by setting theresTime to false and enable the tapGestureRecognisers for extra information
        roundsPlayed += 1
        theresTime = false
        firstTap.isEnabled = true
        secondTap.isEnabled = true
        thirdTap.isEnabled = true
        fourthTap.isEnabled = true
        //Check score, set images for right/wrong, play sound
        if round.correctOrder[0].event == firstOption.text && round.correctOrder[1].event == secondOption.text && round.correctOrder[2].event == thirdOption.text && round.correctOrder[3].event == fourthOption.text {
            print("Answer is correct! Whooo!")
            score += 1
            if roundsPlayed != 6 {
                playAgainButton.setImage(UIImage(named: "next_round_success") , for: .normal)
            } else {
                playAgainButton.setImage(UIImage(named: "play_again") , for: .normal)
            }
            playSound(path: Bundle.main.path(forResource: "CorrectDing", ofType: "wav")!)
            playAgainButton.isHidden = false
        } else {
            print("Answer is wrong! Awww!")
            if roundsPlayed != 6 {
                playAgainButton.setImage(UIImage(named: "next_round_fail") , for: .normal)
            } else {
                playAgainButton.setImage(UIImage(named: "play_again") , for: .normal)
            }
            playSound(path: Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")!)
            playAgainButton.isHidden = false
        }
        explainingLabel.text = "Click events to find out more!"
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        //Test for shaking of device, stop timer and end the round
        if motion == .motionShake {
            timer.invalidate()
            roundEnd()
        }
    }
    @IBAction func nextButton(_ sender: Any) {
        //Check if we need to end the game or start a new round
        if playAgainButton.image(for: .normal) == UIImage(named: "play_again") {
            //End game, hide views, display score, on second touch of the button start a new game
            for view in optionViews {
                view.isHidden = true
            }
            scoreLabel.isHidden = false
            if firstTimeNextRound {
                scoreLabel.text = "Your score was: \(score) out of 6. \n Press the button again to play another round!"
                firstTimeNextRound = false
            } else {
                score = 0
                roundsPlayed = 0
                round = setupRound()
                startRound(round: round)
            }
        } else {
            //Start new round
            round = setupRound()
            startRound(round: round)
        }
    }
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        //Check which one of the views is tapped, get name and url and send to the WebViewController
        switch sender {
        case firstTap:
            var url: String{
                var returnable: String = ""
                for event in events{
                    if event.event == firstOption.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url":url, "title":firstOption.text]
            performSegue(withIdentifier: "showWebVC", sender: sendingData)
        case secondTap:
            var url: String{
                var returnable: String = ""
                for event in events{
                    if event.event == secondOption.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url":url, "title":secondOption.text]
            performSegue(withIdentifier: "showWebVC", sender: sendingData)
        case thirdTap:
            var url: String{
                var returnable: String = ""
                for event in events{
                    if event.event == thirdOption.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url":url, "title":thirdOption.text]
            performSegue(withIdentifier: "showWebVC", sender: sendingData)
        case fourthTap:
            var url: String{
                var returnable: String = ""
                for event in events{
                    if event.event == fourthOption.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url":url, "title":fourthOption.text]
            performSegue(withIdentifier: "showWebVC", sender: sendingData)
        default:
            print("Something went wrong! Oops!")
        }
    }
    
    //Start a new round
    func startRound(round: Round) {
        //Disable tapGesutreRecognisers, set theres time to true, show views and set the base values
        firstTap.isEnabled = false
        secondTap.isEnabled = false
        thirdTap.isEnabled = false
        fourthTap.isEnabled = false
        theresTime = true
        firstTimeNextRound = true
        explainingLabel.text = "Sort the programming languages on founding date. Shake to confirm your answer!"
        time = 0
        playAgainButton.isHidden = true
        for view in optionViews {
            view.isHidden = false
        }
        scoreLabel.isHidden = true
        //Randomly set the events on one of the views
        let options = [round.firstQ.event, round.secondQ.event, round.thirdQ.event, round.fourthQ.event]
        var used: [Int] = []
        var randomNumber = randomNumberGenerator(usedNumbers: used, max: options.count)
        used.append(randomNumber)
        firstOption.text = options[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: used, max: options.count)
        used.append(randomNumber)
        secondOption.text = options[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: used, max: options.count)
        used.append(randomNumber)
        thirdOption.text = options[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: used, max: options.count)
        used.append(randomNumber)
        fourthOption.text = options[randomNumber]
        //All set, start the timer
        startTimer()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebVC" {
            let data = sender as! [String: String]
            let detailVC = segue.destination as! WebViewController
            detailVC.objectTitle = data["title"]
            detailVC.url = data["url"]
        }
    }

}

