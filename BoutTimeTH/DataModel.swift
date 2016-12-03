//
//  DataModel.swift
//  BoutTimeTH
//
//  Created by Jari Koopman on 01/12/2016.
//  Copyright © 2016 JarICT. All rights reserved.
//

import Foundation
import GameKit

//MARK: Struct declaration
struct Round {
    var firstQ: Event
    var secondQ: Event
    var thirdQ: Event
    var fourthQ: Event
    var correctOrder: [Event]{
        let tempEvents = [firstQ, secondQ, thirdQ, fourthQ]
        return tempEvents.sorted {$0.year < $1.year}
    }
}

struct Event {
    let event: String
    let year: Int
    let url: String
}

//MARK: Random number generator
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
//MARK: Events
var usedEvents: [String] = []

let events: [Event] = [
                        Event(event: "Logo", year: 1968, url: "https://en.wikipedia.org/wiki/Logo_(programming_language)"),
                        Event(event: "B", year: 1969, url: "https://en.wikipedia.org/wiki/B_(programming_language)"),
                        Event(event: "Pascal", year: 1970, url: "https://en.wikipedia.org/wiki/Pascal_(programming_language)"),
                        Event(event: "Forth", year: 1970, url: "https://en.wikipedia.org/wiki/Forth_(programming_language)"),
                        Event(event: "C", year: 1972, url: "https://en.wikipedia.org/wiki/C_(programming_language)"),
                        Event(event: "Smalltalk", year: 1972, url: "https://en.wikipedia.org/wiki/Smalltalk"),
                        Event(event: "Prolog", year: 1972, url: "https://en.wikipedia.org/wiki/Prolog"),
                        Event(event: "ML", year: 1973, url: "https://en.wikipedia.org/wiki/ML_(programming_language)"),
                        Event(event: "Scheme", year: 1975, url: "https://en.wikipedia.org/wiki/Scheme_(programming_language)"),
                        Event(event: "SQL", year: 1978, url: "https://en.wikipedia.org/wiki/SQL"),
                        Event(event: "C++", year: 1980, url: "https://en.wikipedia.org/wiki/C%2B%2B"),
                        Event(event: "Ada", year: 1983, url: "https://en.wikipedia.org/wiki/Ada_(programming_language)"),
                        Event(event: "Common Lisp", year: 1984, url: "https://en.wikipedia.org/wiki/Common_Lisp"),
                        Event(event: "MATLAB", year: 1984, url: "https://en.wikipedia.org/wiki/MATLAB"),
                        Event(event: "Eiffel", year: 1985, url: "https://en.wikipedia.org/wiki/Eiffel_(programming_language)"),
                        Event(event: "Objective C", year: 1986, url: "https://en.wikipedia.org/wiki/Objective-C"),
                        Event(event: "Erlang", year: 1986, url: "https://en.wikipedia.org/wiki/Erlang_(programming_language)"),
                        Event(event: "Perl", year: 1987, url: "https://en.wikipedia.org/wiki/Perl"),
                        Event(event: "TCL", year: 1988, url: "https://en.wikipedia.org/wiki/Tcl"),
                        Event(event: "Wolfram Language", year: 1988, url: "https://en.wikipedia.org/wiki/Wolfram_Language"),
                        Event(event: "FL", year: 1989, url: "https://en.wikipedia.org/wiki/FL_(programming_language)"),
                        Event(event: "Haskell", year: 1990, url: "https://en.wikipedia.org/wiki/Haskell_(programming_language)"),
                        Event(event: "Python", year: 1991, url: "https://en.wikipedia.org/wiki/Python_(programming_language)"),
                        Event(event: "Visual Basic", year: 1991, url: "https://en.wikipedia.org/wiki/Visual_Basic"),
                        Event(event: "Ruby", year: 1993, url: "https://en.wikipedia.org/wiki/Ruby_(programming_language)"),
                        Event(event: "Lua", year: 1993, url: "https://en.wikipedia.org/wiki/Lua_(programming_language)"),
                        Event(event: "R", year: 1993, url: "https://en.wikipedia.org/wiki/R_(programming_language)"),
                        Event(event: "CLOS", year: 1994, url: "https://en.wikipedia.org/wiki/CLOS"),
                        Event(event: "Ada 95", year: 1995, url: "https://en.wikipedia.org/wiki/Ada_95"),
                        Event(event: "Java", year: 1995, url: "https://en.wikipedia.org/wiki/Java_(programming_language)"),
                        Event(event: "Delphi", year: 1995, url: "https://en.wikipedia.org/wiki/Embarcadero_Delphi"),
                        Event(event: "JavaScript", year: 1995, url: "https://en.wikipedia.org/wiki/JavaScript"),
                        Event(event: "PHP", year: 1995, url: "https://en.wikipedia.org/wiki/PHP"),
                        Event(event: "Rebol", year: 1997, url: "https://en.wikipedia.org/wiki/REBOL"),
                        Event(event: "D", year: 1999, url: "https://en.wikipedia.org/wiki/D_(programming_language)"),
                        Event(event: "ActionScript", year: 2000, url: "https://en.wikipedia.org/wiki/ActionScript"),
                        Event(event: "C#", year: 2001, url: "https://en.wikipedia.org/wiki/C_Sharp_(programming_language)"),
                        Event(event: "Apache Groovy", year: 2003, url: "https://en.wikipedia.org/wiki/Groovy_(programming_language)"),
                        Event(event: "Scala", year: 2003, url: "https://en.wikipedia.org/wiki/Scala_(programming_language)"),
                        Event(event: "F#", year: 2005, url: "https://en.wikipedia.org/wiki/F_Sharp_(programming_language)"),
                        Event(event: "Windows Powershell", year: 2006, url: "https://en.wikipedia.org/wiki/Windows_PowerShell"),
                        Event(event: "Clojure", year: 2007, url: "https://en.wikipedia.org/wiki/Clojure"),
                        Event(event: "Go", year: 2009, url: "https://en.wikipedia.org/wiki/Go_(programming_language)"),
                        Event(event: "Rust", year: 2010, url: "https://en.wikipedia.org/wiki/Rust_(programming_language)"),
                        Event(event: "Dart", year: 2011, url: "https://en.wikipedia.org/wiki/Dart_(programming_language)"),
                        Event(event: "Julia", year: 2012, url: "https://en.wikipedia.org/wiki/Julia_(programming_language)"),
                        Event(event: "Swift", year: 2014, url: "https://en.wikipedia.org/wiki/Swift_(programming_language)")
                        ]

//MARK: Setup of a round
func setupRound() -> Round {
    //Make a temporary round to which we'll add objects later
    var round: Round = Round(firstQ: events[0], secondQ: events[0], thirdQ: events[0], fourthQ: events[0])
    var EventsFit = false
    var usedNumbers: [Int] = []
    while EventsFit != true {
        //Add random events to the round object
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
        //Check if the events don't lie more that 15 years apart to not make it too difficult, also check if they didn't happen in the same year
        if (fourthEvent.year.distance(to: thirdEvent.year) <= 15 && fourthEvent.year.distance(to: thirdEvent.year) != 0) && (thirdEvent.year.distance(to: secondEvent.year) <= 15 && thirdEvent.year.distance(to: secondEvent.year) != 0) && (secondEvent.year.distance(to: firstEvent.year) <= 15 && secondEvent.year.distance(to: firstEvent.year) != 0) && usedEvents.contains(firstEvent.event) == false && usedEvents.contains(secondEvent.event) == false && usedEvents.contains(thirdEvent.event) == false && usedEvents.contains(fourthEvent.event) == false {
                EventsFit = true
                round.firstQ = firstEvent
                round.secondQ = secondEvent
                round.thirdQ = thirdEvent
                round.fourthQ = fourthEvent
                usedEvents.append(fourthEvent.event)
                usedEvents.append(thirdEvent.event)
                usedEvents.append(secondEvent.event)
                usedEvents.append(firstEvent.event)
        } else {
            print("Not working!")
        }
    }
    return round
}

//MARK: Sound data

var gameSound: SystemSoundID = 0
//Function to play a game sound
func playSound(path: String) {
    let soundURL = NSURL(fileURLWithPath: path)
    AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    AudioServicesPlaySystemSound(gameSound)
}
