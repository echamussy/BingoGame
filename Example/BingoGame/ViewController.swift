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
        
        let cardArray = BingoDeck.createCardArrayFrom(elements: ["apple", "lemon", "rasberry", "blueberry", "orange", "paprika", "corn", "brocoli", "mushroom", "pineapple", "strawberry", "apple"])
        let gameConfiguration = BingoGameConfiguration(playerIds:["Emma", "Manuel"],
                                                       availableCards:cardArray)
        self.bingoGame = BingoGame(configuration: gameConfiguration, delegate:self)
        self.bingoGame.startGame()
        
        // Play the game!
        for i in 0...(cardArray.count - 1) {
            self.bingoGame.openCard(atIndex: i)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let podBundle = Bundle(for:BingoViewController.self)
        let bingoViewController = BingoViewController(nibName: "BingoViewController", bundle: podBundle)
        self.present(bingoViewController, animated: false, completion: nil)
    }
}

extension ViewController:BingoGameDelegate{
    
    func bingoGameDidStart(_ game: BingoGame) {
        
    }
    
    func bingoGame(_ game: BingoGame, cardOpened: BingoCard) {
        
    }
    
    func bingoGame(_ game: BingoGame, deckCompleted byPlayer: BingoPlayer) {
        print("Player '\(byPlayer.playerId)' completed deck!")
        self.bingoGame.printGameStatus()
    }
    
    
    
}

