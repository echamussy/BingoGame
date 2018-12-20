//
//  BingoPlayer.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 14/12/2018.
//

import Foundation

public struct BingoPlayerConfiguration:Codable{
    public let playerId:String
    public let assignedCards:Array<BingoCard>?
    
    public init (playerId:String, assignedCards:Array<BingoCard>? = nil){
        self.playerId = playerId
        self.assignedCards = assignedCards
    }
}

public struct BingoPlayer{
    
    public let configuration:BingoPlayerConfiguration
    public var assignedDeck:BingoDeck
    public var score:Int {
        return self.assignedDeck.openedCards.count
    }
    
}
