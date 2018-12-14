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
    
    public func openCard(atIndex:Int){
        if (atIndex < self.cards.count){
            let chosenCard = self.cards[atIndex]
            let cardAlreadyOpened = self.openedCards.contains(where: { (card) -> Bool in
                return card.name == chosenCard.name
            })
            
            if (!cardAlreadyOpened){
                self.openedCards.append(chosenCard)
            }
        }
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
