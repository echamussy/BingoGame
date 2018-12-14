//
//  BingoGame.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 14/12/2018.
//

import Foundation

public struct BingoGameConfiguration{

    public let playerNames:Array<String>
    public let availableCards:Array<BingoCard> // Should always be dividable by number of players with remainder 0

    public init(playerNames:Array<String>, availableCards:Array<BingoCard>){
        self.playerNames = playerNames
        self.availableCards = availableCards
    }
}

public class BingoGame {
    
    private var configuration:BingoGameConfiguration
    private var mainDeck:BingoDeck!
    private var players:Array<BingoPlayer> = []
    
    public init(configuration:BingoGameConfiguration) {
        self.configuration = configuration
        self.restartGame(configuration: configuration)
    }

    public func restartGame(configuration:BingoGameConfiguration){
        self.configuration = configuration
        self.setupGame()
    }
}

private extension BingoGame{
    
    private func setupGame(){
        if (self.verifyGameConfiguration()){
            self.randomizeMainDeck()
            self.configureUsers()
        } else {
            // TODO: Report an error!
        }
    }
    
    private func verifyGameConfiguration() -> Bool{
        if (configuration.availableCards.count % self.configuration.playerNames.count == 0){
            return true
        } else {
            print("BINGO GAME ERROR: The number of available cards does not divide exactly between players!")
            return false
        }
    }
    
    private func randomizeMainDeck(){
        if mainDeck != nil { mainDeck.reset() }
        self.mainDeck = BingoDeck(cards: self.configuration.availableCards)
    }
    
    private func configureUsers(){
        self.players.removeAll()
        self.configuration.playerNames.forEach { (playerName) in
            let playerDeck = BingoDeck(cards: [])
            let player = BingoPlayer(name:playerName, assignedDeck:playerDeck)
            self.players.append(player)
        }
    }
    
    
    
}
