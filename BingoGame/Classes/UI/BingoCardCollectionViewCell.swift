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
            self.imageView.alpha = 0.5
        }
    }
    
    public func upTurn(completion: (@escaping () -> Void)){
        UIView.transition(with: contentView,
                          duration: 1,
                          options: .transitionFlipFromRight,
                          animations: {
                            self.imageView.image = UIImage(named: "bingo-card-\(self.card.name)")
        }, completion: { (_) in
            UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseInOut], animations: {
                self.imageView.alpha = 0.0
            }, completion: { (_) in
                
            })
            completion()
        })
    }
    
    public func animateFound(completion: (@escaping () -> Void)){
        if let animationPath = Bundle(for:BingoCardCollectionViewCell.self).path(forResource: "favourite_app_icon", ofType: "json"){
            let lottieView = LOTAnimationView(filePath: animationPath)
            lottieView.contentMode = .scaleAspectFit
            lottieView.frame = CGRect(x: ((self.animationView.frame.size.width / 2) * -1),
                                      y: ((self.animationView.frame.size.height / 2) * -1),
                                      width: self.animationView.frame.size.width * 2,
                                      height: self.animationView.frame.size.height * 2)
            lottieView.loopAnimation = false
            
            self.imageView.alpha = 0.0
            
            self.animationView.addSubview(lottieView)
            lottieView.play { (_) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    lottieView.removeFromSuperview()
                    self.imageView.alpha = 1.0
                    completion()
                }
            }
        
        }
    }

}
