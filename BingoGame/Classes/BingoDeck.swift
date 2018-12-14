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
        
    }
    
    public func reset(){
        self.cards.removeAll()
        self.openedCards.removeAll()
    }
    
    // MARK: Static helper methods
    
    public static func createDeckFrom(elements:Array<String>)->BingoDeck{
        var cards:Array<BingoCard> = []
        elements.forEach { (element) in
            let bingoCard = BingoCard(name:element)
            cards.append(bingoCard)
        }
        return BingoDeck(cards: cards)
    }
    
}
