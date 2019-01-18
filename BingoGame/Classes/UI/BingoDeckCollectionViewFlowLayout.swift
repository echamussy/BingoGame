//
//  BingoDeckCollectionViewFlowLayout.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import Foundation

public class BingoDeckCollectionViewFlowLayout:UICollectionViewFlowLayout{
    
    var deck:BingoDeck
    
    private let space:CGFloat = 6
    
    init(deck:BingoDeck) {
        self.deck = deck
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) should not be called")
    }
    
    override public func prepare() {
        super.prepare()
        self.itemSize = self.cardSizeFor(space: self.space)
        self.minimumLineSpacing = self.space
        self.minimumInteritemSpacing = self.space
        self.sectionInset = UIEdgeInsets(top: space, left: space, bottom: 0, right: space)
        
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func cardSizeFor(space:CGFloat)->CGSize{
        
        if let collectionView = self.collectionView{
            let (columns, rows) = self.sizeForCurrentDeck()
            
            let collectionViewInset = space * 2.0
            let cardWidth:CGFloat = ((collectionView.frame.width - collectionViewInset)  / columns) - space
            let cardHeight:CGFloat = (collectionView.frame.height / rows) - space
            
            return CGSize(width: cardWidth, height: cardHeight)
        } else {
            print("Collection view is not set!")
            return CGSize.zero
        }
    }
    
    private func sizeForCurrentDeck()->(CGFloat, CGFloat){
        if (self.deck.cards.count <= 6) {
            if self.collectionView!.frame.size.width > 200.0{
                return (CGFloat(2.0), CGFloat(3.0))
            } else {
                return (CGFloat(1.0), CGFloat(6.0))
            }
        } else {
            return (CGFloat(3.0), CGFloat(4.0))
        }
        
    }
    
    
}
