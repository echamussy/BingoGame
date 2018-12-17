//
//  BingoCardCollectionViewCell.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

class BingoCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func render(card:BingoCard){
        self.nameLabel.text = card.name
    }

}
