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
    }

    public func startGame(newConfiguration:BingoGameConfiguration? = nil){
        print("Will start setting up a new Bingo game")
        if let newConfiguration = newConfiguration{
            self.configuration = newConfiguration
        }
        self.setupGame()
    }
    
    public func openCard(atIndex:Int){
        self.mainDeck.openCard(atIndex:atIndex)
    }
    
    public func printGameStatus(){
        print("Main Deck: \(self.mainDeck.cards)")
        self.players.forEach { (player) in
            print("Player '\(player.name)' has cards: \(player.assignedDeck.cards)")
            print("Player '\(player.name)' has found cards: \(player.assignedDeck.openedCards)")
        }
    }
}

private extension BingoGame{
    
    private func setupGame(){
        if (self.verifyGameConfiguration()){
            self.configureMainDeck()
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
    
    // MARK: Configuration methods
    
    private func configureMainDeck(){
        if mainDeck != nil { mainDeck.reset() }
        self.mainDeck = BingoDeck(cards: self.configuration.availableCards)
        self.mainDeck.shuffle()
    }
    
    private func configureUsers(){
        self.players.removeAll()
        
        var playerIndex = 0
        let numberOfCardsPerPlayer = Int(self.mainDeck.cards.count / self.configuration.playerNames.count)
        let shuffledCardsForPlayers = self.mainDeck.cards.shuffled()
        
        self.configuration.playerNames.forEach { (playerName) in
            let startIndex = playerIndex * numberOfCardsPerPlayer
            let endIndex = ((playerIndex + 1) * numberOfCardsPerPlayer) - 1
            
            let playerCards = Array(shuffledCardsForPlayers[startIndex...endIndex])
            let playerDeck = BingoDeck(cards: playerCards)
            
            let player = BingoPlayer(name:playerName, assignedDeck:playerDeck)
            self.players.append(player)
            playerIndex = playerIndex + 1
        }
    }
    
}
