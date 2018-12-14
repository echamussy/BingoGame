//
//  BingoGame.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 14/12/2018.
//

import Foundation

public struct BingoGameConfiguration{

    public let playerIds:Array<String>
    public let availableCards:Array<BingoCard> // Should always be dividable by number of players with remainder 0

    public init(playerIds:Array<String>, availableCards:Array<BingoCard>){
        self.playerIds = playerIds
        self.availableCards = availableCards
    }
}

public protocol BingoGameDelegate{
    
    func newGameReady(game:BingoGame)
    
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
        let card = self.mainDeck.getCard(atIndex: atIndex)
        if let card = card {
            _ = self.mainDeck.openCard(atIndex: atIndex)
            self.players.forEach { (player) in
                _ = player.assignedDeck.open(chosenCard: card)
            }
        }
    }
    
    public func printGameStatus(){
        print("Main Deck: \(self.mainDeck.cards)")
        print("Opened cards: \(self.mainDeck.openedCards)")
        self.players.forEach { (player) in
            print("Player '\(player.playerId)' has cards: \(player.assignedDeck.cards)")
            print("Player '\(player.playerId)' has found cards: \(player.assignedDeck.openedCards)")
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
        if (configuration.availableCards.count % self.configuration.playerIds.count == 0){
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
        let numberOfCardsPerPlayer = Int(self.mainDeck.cards.count / self.configuration.playerIds.count)
        let shuffledCardsForPlayers = self.mainDeck.cards.shuffled()
        
        self.configuration.playerIds.forEach { (playerId) in
            let startIndex = playerIndex * numberOfCardsPerPlayer
            let endIndex = ((playerIndex + 1) * numberOfCardsPerPlayer) - 1
            
            let playerCards = Array(shuffledCardsForPlayers[startIndex...endIndex])
            let playerDeck = BingoDeck(cards: playerCards)
            
            let player = BingoPlayer(playerId:playerId, assignedDeck:playerDeck)
            self.players.append(player)
            playerIndex = playerIndex + 1
        }
    }
    
}
