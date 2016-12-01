//
//  DataModel.swift
//  BoutTimeTH
//
//  Created by Jari Koopman on 01/12/2016.
//  Copyright © 2016 JarICT. All rights reserved.
//

import Foundation
import GameKit

struct Round {
    var firstQ: Event
    var secondQ: Event
    var thirdQ: Event
    var fourthQ: Event
    var correctOrder: [Event]{
        let tempEvents = [firstQ, secondQ, thirdQ, fourthQ]
        print(tempEvents.sorted {$0.year > $1.year}
        )
        return tempEvents.sorted {$0.year > $1.year}
    }
}

struct Event {
    let event: String
    let year: Int
}

//Random number generator
func numberGenerator(max: Int) -> Int {
    let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: max)
    return randomNumber
}
//The number created above may have been used already, here that is checked, if the number is used we generate a new one, otherwise we return it
func randomNumberGenerator(usedNumbers: [Int], max: Int) -> Int {
    //Get a number from the numberGenerator
    var randomNumber = numberGenerator(max: max)
    //Check if it's in the usedNumbers array
    while usedNumbers.contains(randomNumber) {
        //The number is already used, create a new one and check again
        randomNumber = numberGenerator(max: max)
    }
    //Return a number that is not used before
    return randomNumber
}

let events: [Event] = [Event(event: "Logo", year: 1968),
                            Event(event: "B", year: 1969),
                             Event(event: "Pascal", year: 1970),
                             Event(event: "Forth", year: 1970),
                             Event(event: "C", year: 1972),
                             Event(event: "Smalltalk", year: 1972),
                             Event(event: "Prolog", year: 1972),
                             Event(event: "ML", year: 1973),
                             Event(event: "Scheme", year: 1975),
                             Event(event: "SQL", year: 1978),
                             Event(event: "C++", year: 1980),
                             Event(event: "Ada", year: 1983),
                             Event(event: "Common Lisp", year: 1984),
                             Event(event: "MATLAB", year: 1984),
                             Event(event: "Eiffel", year: 1985),
                             Event(event: "Objective C", year: 1986),
                             Event(event: "Erlang", year: 1986),
                             Event(event: "Perl", year: 1987),
                             Event(event: "TCL", year: 1988),
                             Event(event: "Wolfram Language", year: 1988),
                             Event(event: "FL", year: 1989),
                             Event(event: "Haskell", year: 1990),
                             Event(event: "Python", year: 1991),
                             Event(event: "Visual Basic", year: 1991),
                             Event(event: "Ruby", year: 1993),
                             Event(event: "Lua", year: 1993),
                             Event(event: "R", year: 1993),
                             Event(event: "CLOS", year: 1994),
                             Event(event: "Ada 95", year: 1995),
                             Event(event: "Java", year: 1995),
                             Event(event: "Delphi", year: 1995),
                             Event(event: "JavaScript", year: 1995),
                             Event(event: "PHP", year: 1995),
                             Event(event: "Rebol", year: 1997),
                             Event(event: "D", year: 1999),
                             Event(event: "ActionScript", year: 2000),
                             Event(event: "C#", year: 2001),
                             Event(event: "Apache Groovy", year: 2003),
                             Event(event: "Scala", year: 2003),
                             Event(event: "F#", year: 2005),
                             Event(event: "Windows Powershell", year: 2006),
                             Event(event: "Clojure", year: 2007),
                             Event(event: "Go", year: 2009),
                             Event(event: "Rust", year: 2010),
                             Event(event: "Dart", year: 2011),
                             Event(event: "Julia", year: 2012),
                             Event(event: "Swift", year: 2014)
                            ]

func setupRound() -> Round {
    var round: Round = Round(firstQ: events[0], secondQ: events[0], thirdQ: events[0], fourthQ: events[0])
    var EventsFit = false
    var usedNumbers: [Int] = []
    while EventsFit != true {
        usedNumbers.removeAll()
        var randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
        usedNumbers.append(randomNumber)
        let firstEvent = events[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
        usedNumbers.append(randomNumber)
        let secondEvent = events[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
        usedNumbers.append(randomNumber)
        let thirdEvent = events[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: usedNumbers, max: events.count)
        usedNumbers.append(randomNumber)
        let fourthEvent = events[randomNumber]
        
        if (fourthEvent.year.distance(to: thirdEvent.year) <= 10 && fourthEvent.year.distance(to: thirdEvent.year) != 0) && (thirdEvent.year.distance(to: secondEvent.year) <= 10 && thirdEvent.year.distance(to: secondEvent.year) != 0) && (secondEvent.year.distance(to: firstEvent.year) <= 10 && secondEvent.year.distance(to: firstEvent.year) != 0) {
            EventsFit = true
            round.firstQ = firstEvent
            round.secondQ = secondEvent
            round.thirdQ = thirdEvent
            round.fourthQ = fourthEvent
        } else {
            print("Not working!")
        }
    }
    return round
}
