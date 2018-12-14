//
//  BingoDeck.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 14/12/2018.
//

import Foundation
import GameKit

public class BingoDeck{
    
    public var cards:Array<BingoCard>
    public var openedCards:Array<BingoCard>
    
    public init(cards:Array<BingoCard>){
        self.cards = cards
        self.openedCards = []
    }
    
    public func shuffle(){
        self.cards.shuffle()
    }
    
    public func reset(){
        self.cards.removeAll()
        self.openedCards.removeAll()
    }
    
    public func openCard(atIndex:Int)->Bool{
        if (atIndex < self.cards.count){
            let chosenCard = self.cards[atIndex]
            return self.open(chosenCard: chosenCard)
        } else {
            return false
        }
    }
    
    public func open(chosenCard:BingoCard)-> Bool{
        guard self.has(card: chosenCard) else {
            return false
        }
        
        let cardAlreadyOpened = self.openedCards.contains(where: { (card) -> Bool in
            return card == chosenCard
        })
        
        if (!cardAlreadyOpened){
            self.openedCards.append(chosenCard)
            return true
        } else {
            return false
        }
    }
    
    public func has(card:BingoCard)-> Bool{
        return self.cards.contains(where: { (deckCard) -> Bool in
            return deckCard == card
        })
    }
    
    public func getCard(atIndex:Int)->BingoCard?{
        if (atIndex < self.cards.count){
            return self.cards[atIndex]
        }
        return nil
    }
    
    // MARK: Static helper methods
    
    public static func createCardArrayFrom(elements:Array<String>)->Array<BingoCard>{
        var cards:Array<BingoCard> = []
        elements.forEach { (element) in
            let bingoCard = BingoCard(name:element)
            cards.append(bingoCard)
        }
        return cards
    }
    
}
