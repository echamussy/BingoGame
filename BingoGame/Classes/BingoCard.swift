//
//  BingoCard.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 14/12/2018.
//

import Foundation

public struct BingoCard: Codable, CustomStringConvertible{
    
    public var name:String
    public var imageName:String?
    
    public var description: String {
        return name
    }
    
    public init(name:String, imageName:String? = nil){
        self.name = name
        self.imageName = imageName
    }
    
}
