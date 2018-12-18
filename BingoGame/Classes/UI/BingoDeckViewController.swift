//
//  BingoDeckViewController.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

protocol BingoDeckViewControllerDelegate:class{
    func bingoDeck(_ bingoDeckViewController:BingoDeckViewController, cardOpened:BingoCard)
}

class BingoDeckViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
        let collectionViewLayout = BingoDeckCollectionViewFlowLayout(deck:self.deck)
        self.collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
        
        let bundle = Bundle(for: BingoCardCollectionViewCell.self)
        self.collectionView.register(UINib(nibName: "BingoCardCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "cardCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
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
            self.delegate?.bingoDeck(self, cardOpened: card)
        } else {
            // Ignoring as the player deck does not have interaction directly
        }
    }
}
