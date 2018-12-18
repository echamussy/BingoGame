//
//  BingoCardCollectionViewCell.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit
import Lottie

class BingoCardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var animationView: UIView!
    
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
            self.imageView.alpha = 0.75
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
    
    public func animateFound(){
        if let animationPath = Bundle(for:BingoCardCollectionViewCell.self).path(forResource: "favourite_app_icon", ofType: "json"){
            let lottieView = LOTAnimationView(filePath: animationPath)
            lottieView.frame = CGRect(x: 0, y: 0,
                                      width: self.animationView.frame.size.width,
                                      height: self.animationView.frame.size.height)
            lottieView.loopAnimation = false
            
            self.animationView.addSubview(lottieView)
            lottieView.play { (_) in
                lottieView.removeFromSuperview()
                self.imageView.alpha = 1.0
            }
        }
    }

}
