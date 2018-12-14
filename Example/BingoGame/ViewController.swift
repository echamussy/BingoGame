//
//  ViewController.swift
//  BingoGame
//
//  Created by echamussy on 12/14/2018.
//  Copyright (c) 2018 echamussy. All rights reserved.
//

import UIKit
import BingoGame


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainDeck = BingoDeck.createDeckFrom(elements: ["apple", "lemon", "rasberry", "blueberry", "orange"])
        let gameConfiguration = BingoGameConfiguration(playerNames:["Emma", "Manuel"],
                                                       availableCards:mainDeck.cards)
        let bingoGame = BingoGame(configuration: gameConfiguration)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

