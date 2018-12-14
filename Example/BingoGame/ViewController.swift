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

    var bingoGame:BingoGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardArray = BingoDeck.createCardArrayFrom(elements: ["apple", "lemon", "rasberry", "blueberry", "orange", "paprika"])
        let gameConfiguration = BingoGameConfiguration(playerNames:["Emma", "Manuel"],
                                                       availableCards:cardArray)
        self.bingoGame = BingoGame(configuration: gameConfiguration)
        self.bingoGame.startGame()
        self.bingoGame.printGameStatus()
        self.bingoGame.openCard(atIndex: 0)
        self.bingoGame.printGameStatus()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

