//
//  BingoCardCollectionViewCell.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

class BingoCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    private var card:BingoCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func render(card:BingoCard, inDeck:BingoDeck){
        self.card = card
        switch inDeck.type {
        case .mainDeck:
            self.imageView.image = UIImage(named: "bingo-closed-card")
        case .playerDeck:
            self.imageView.image = UIImage(named: "bingo-card-\(card.name)")
        }
    }
    
    public func upTurn(){
        UIView.transition(with: contentView,
                          duration: 1,
                          options: .transitionFlipFromRight,
                          animations: {
                            self.imageView.image = UIImage(named: "bingo-card-\(self.card.name)")
        }, completion: nil)
    }

}
