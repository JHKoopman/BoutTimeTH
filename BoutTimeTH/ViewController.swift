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

    override func viewDidLoad() {
        super.viewDidLoad()
        playAgainButton.isHidden = true
        timerLabel.text = "60"
        
        let round = setupRound()
        startRound(round: round)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func startRound(round: Round) {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

