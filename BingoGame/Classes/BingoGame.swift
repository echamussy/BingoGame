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
    public let shuffleCardsAtStart:Bool

    public init(playerIds:Array<String>, availableCards:Array<BingoCard>, shuffleCardsAtStart:Bool){
        self.playerIds = playerIds
        self.availableCards = availableCards
        self.shuffleCardsAtStart = shuffleCardsAtStart
    }
}

public protocol BingoGameDelegate:class {
    
    func bingoGameDidStart(_ game:BingoGame)
    func bingoGame(_ game:BingoGame, cardOpened:BingoCard)
    func bingoGame(_ game:BingoGame, deckCompleted byPlayer:BingoPlayer)
    
}

public class BingoGame {
    
    private var configuration:BingoGameConfiguration
    public private(set) var mainDeck:BingoDeck!
    public private(set) var players:Array<BingoPlayer> = []
    public weak var delegate:BingoGameDelegate?
    
    public init(configuration:BingoGameConfiguration, delegate:BingoGameDelegate?) {
        self.configuration = configuration
        self.delegate = delegate
    }

    public func startGame(newConfiguration:BingoGameConfiguration? = nil){
        print("Will start setting up a new Bingo game")
        if let newConfiguration = newConfiguration{
            self.configuration = newConfiguration
        }
        self.setupGame()
        self.delegate?.bingoGameDidStart(self)
    }
    
    public func openCard(atIndex:Int){
        let card = self.mainDeck.getCard(atIndex: atIndex)
        if let card = card {
            _ = self.mainDeck.openCard(atIndex: atIndex)
            self.players.forEach { (player) in
                let cardOpened = player.assignedDeck.open(chosenCard: card)
                if (cardOpened){ self.handleDeckUpdatedFor(player:player) }
            }
            self.delegate?.bingoGame(self, cardOpened: card)
            
        }
    }
    
    public func printGameStatus(){
        print("Main Deck: \(self.mainDeck.cards)")
        print("Opened cards: \(self.mainDeck.openedCards)")
        self.players.forEach { (player) in
            print("Player '\(player.playerId)' has cards: \(player.assignedDeck.cards)")
            print("Player '\(player.playerId)' has found cards: \(player.assignedDeck.openedCards)")
            print("Player '\(player.playerId)' score: \(player.assignedDeck.openedCards.count)")
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
    
    private func handleDeckUpdatedFor(player:BingoPlayer){
        if (player.assignedDeck.cards.count == player.assignedDeck.openedCards.count){
            // Player completed deck
            self.delegate?.bingoGame(self, deckCompleted: player)
        }
    }
    
    // MARK: Configuration methods
    
    private func configureMainDeck(){
        if mainDeck != nil { mainDeck.reset() }
        self.mainDeck = BingoDeck(cards: self.configuration.availableCards, type:.mainDeck)
        if self.configuration.shuffleCardsAtStart { self.mainDeck.shuffle() }
    }
    
    private func configureUsers(){
        self.players.removeAll()
        
        var playerIndex = 0
        let numberOfCardsPerPlayer = Int(self.mainDeck.cards.count / self.configuration.playerIds.count)
        let cardsForPlayers = (self.configuration.shuffleCardsAtStart ? self.mainDeck.cards.shuffled() : self.mainDeck.cards)
        
        self.configuration.playerIds.forEach { (playerId) in
            let startIndex = playerIndex * numberOfCardsPerPlayer
            let endIndex = ((playerIndex + 1) * numberOfCardsPerPlayer) - 1
            
            let playerCards = Array(cardsForPlayers[startIndex...endIndex])
            let playerDeck = BingoDeck(cards: playerCards, type:.playerDeck)
            
            let player = BingoPlayer(playerId:playerId, assignedDeck:playerDeck)
            self.players.append(player)
            playerIndex = playerIndex + 1
        }
    }
    
}
