//
//  BingoDeckViewController.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

class BingoDeckViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var deck:BingoDeck
    
    // MARK: Initializers
    init(deck:BingoDeck) {
        self.deck = deck
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
        
        cell.render(card: card)
        
        /*
        cell.makeCurvedCorners(5.0)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1.0
        cell.imageObject = self.images[indexPath.row]
        cell.render()*/
        
        return cell
    }
    
}

extension BingoDeckViewController:UICollectionViewDelegate {
    
    
    
}
