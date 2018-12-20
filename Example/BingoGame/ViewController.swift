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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let cardArray = BingoDeck.createCardArrayFrom(elements: ["apple", "avocado", "banana", "blackberry", "cherry", "kiwi", "orange", "pear", "pineapple", "raspberry", "strawberry", "watermelon"])
        let gameConfiguration = BingoGameConfiguration(playerIds:["Emma", "Manuel"],
                                                       availableCards:cardArray,
                                                       shuffleCardsAtStart:true)
        let bingoGame = BingoGame(configuration: gameConfiguration)
        bingoGame.startGame()
        
        let bingoViewController = BingoGameViewController(bingoGame: bingoGame)
        self.present(bingoViewController, animated: false, completion: nil)
    }
}

