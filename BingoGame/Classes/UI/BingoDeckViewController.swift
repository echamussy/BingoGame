//
//  BingoDeckViewController.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit
import Lottie

protocol BingoDeckViewControllerDelegate:class{
    func bingoDeck(_ bingoDeckViewController:BingoDeckViewController, cardOpened:BingoCard)
}

class BingoDeckViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animationView: UIView!
    
    private var deck:BingoDeck
    private weak var delegate:BingoDeckViewControllerDelegate?
    
    // MARK: Initializers
    init(deck:BingoDeck, delegate:BingoDeckViewControllerDelegate? = nil) {
        self.deck = deck
        self.delegate = delegate
        let bundle = Bundle(for: BingoDeckViewController.self)
        super.init(nibName: "BingoDeckViewController", bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animationView.isHidden = true
        let collectionViewLayout = BingoDeckCollectionViewFlowLayout(deck:self.deck)
        self.collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 5.0

        let bundle = Bundle(for: BingoCardCollectionViewCell.self)
        self.collectionView.register(UINib(nibName: "BingoCardCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "cardCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: Public methods
    
    public func handleOpened(card:BingoCard){
        if self.deck.cards.contains(card){
            if let cardIndex = self.deck.cards.index(of:card){
                let indexPath = IndexPath(row: cardIndex, section: 0)
                let cellSelected = self.collectionView.cellForItem(at: indexPath) as! BingoCardCollectionViewCell
                cellSelected.animateFound {
                    self.checkIfWinner()
                }
            }
        }
    }
    
    // MARK: Private methods
    
    private func checkIfWinner(){
        if self.deck.cards.count == self.deck.openedCards.count{
            // We have copleted our deck
            if let animationPath = Bundle(for:BingoCardCollectionViewCell.self).path(forResource: "trophy", ofType: "json"){
                let lottieView = LOTAnimationView(filePath: animationPath)
                lottieView.contentMode = .scaleAspectFit
                lottieView.frame = self.animationView.frame
                lottieView.loopAnimation = false
                
                self.animationView.isHidden = false
                self.collectionView.isHidden = true
                self.animationView.addSubview(lottieView)
                lottieView.play { (_) in
                    
                }
            }
        }
    }

}

extension BingoDeckViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.deck.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! BingoCardCollectionViewCell
        let card = self.deck.cards[indexPath.row]
        
        cell.render(card: card, inDeck:self.deck)
        
        return cell
    }
    
}

extension BingoDeckViewController:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.deck.type == .mainDeck{
            let card = self.deck.cards[indexPath.row]
            
            if self.deck.openedCards.contains(card){
                // Card is already opened
            } else {
                let cellSelected = self.collectionView.cellForItem(at: indexPath) as! BingoCardCollectionViewCell
                cellSelected.upTurn {
                    self.delegate?.bingoDeck(self, cardOpened: card)
                }
            }
        } else {
            // Ignoring as the player deck does not have interaction directly
        }
    }
}
