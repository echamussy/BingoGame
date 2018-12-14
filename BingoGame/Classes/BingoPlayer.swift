//
//  BingoPlayer.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 14/12/2018.
//

import Foundation

public struct BingoPlayer{
    
    public let playerId:String
    public var assignedDeck:BingoDeck
    public var score:Int {
        return self.assignedDeck.openedCards.count
    }
    
}
