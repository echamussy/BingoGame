//
//  BingoCardCollectionViewCell.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

class BingoCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var containerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    public func render(card:BingoCard){
        /*
        let cellSize = self.frame.size
        if (cellSize.width < cellSize.height){
            self.containerWidthConstraint.constant = cellSize.height
            self.containerHeightConstraint.constant = cellSize.height
        } else {
            self.containerWidthConstraint.constant = cellSize.width
            self.containerHeightConstraint.constant = cellSize.width
        }*/
        
        self.nameLabel.text = card.name
        
    }

}
