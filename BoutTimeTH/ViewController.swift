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
    @IBOutlet weak var explainingLabel: UILabel!
    
    var timer: Timer = Timer()
    var time = 0
    var theresTime = true
    var round: Round!

    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
        timerLabel.text = String(60 - time)
        explainingLabel.text = "Sort the programming languages on founding date. Shake to confirm your answer!"
        explainingLabel.numberOfLines = 0
        
        round = setupRound()
        print(round.correctOrder)
        startRound(round: round)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        if theresTime {
            switch sender {
            case bottomUpButton:
                print("Bottom Up button!")
                let currentText = fourthOption.text
                let aboveText = thirdOption.text
                fourthOption.text = aboveText
                thirdOption.text = currentText
            case secondUpButton:
                print("Second Up button!")
                let currentText = secondOption.text
                let aboveText = firstOption.text
                secondOption.text = aboveText
                firstOption.text = currentText
            case thirdUpButton:
                print("Third Up button!")
                let currentText = thirdOption.text
                let aboveText = secondOption.text
                thirdOption.text = aboveText
                secondOption.text = currentText
            case topDownButton:
                print("Top Down button!")
                let currentText = firstOption.text
                let belowText = secondOption.text
                firstOption.text = belowText
                secondOption.text = currentText
            case secondDownButton:
                print("Second Down button!")
                let currentText = secondOption.text
                let belowText = thirdOption.text
                secondOption.text = belowText
                thirdOption.text = currentText
            case thirdDownButton:
                print("Third Down button!")
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        time += 1
        timerLabel.text = String(60 - time)
        
        if time == 60 {
            timer.invalidate()
            roundEnd()
        }
    }
    
    func roundEnd() {
        print("ROUND IS OVER!")
        theresTime = false
        //Check score
        if round.correctOrder[0].event == firstOption.text && round.correctOrder[1].event == secondOption.text && round.correctOrder[2].event == thirdOption.text && round.correctOrder[3].event == fourthOption.text {
            print("Answer is correct! Whooo!")
        } else {
            print("Answer is wrong! Awww!")
        }
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("SHAKE")
            timer.invalidate()
            roundEnd()
        }
    }
    
    func startRound(round: Round) {
        theresTime = true
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
        time = 0
        startTimer()
    }

}

