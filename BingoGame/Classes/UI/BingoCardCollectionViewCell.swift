//
//  BingoCardCollectionViewCell.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

class BingoCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func render(card:BingoCard){
        //self.imageView.image = UIImage(named: "bingo-closed-card")
        self.imageView.image = UIImage(named: "bingo-card-\(card.name)")
    }

}
