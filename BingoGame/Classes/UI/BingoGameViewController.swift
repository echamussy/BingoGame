//
//  BingoViewController.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

protocol BingoGameViewControllerDelegate {
    func bingoGame(viewController:BingoGameViewController, shouldAllowOpenCard:BingoCard)->Bool
}

public class BingoGameViewController: UIViewController {

    @IBOutlet public weak var localPlayerViewContainer: UIView!
    @IBOutlet public weak var mainDeckViewContainer: UIView!
    @IBOutlet public weak var remotePlayerViewContainer: UIView!
    @IBOutlet public weak var localPlayerLabel: UILabel!
    @IBOutlet public weak var remotePlayerLabel: UILabel!
    
    private var localPlayerDeckViewController:BingoDeckViewController!
    private var remotePlayerDeckViewController:BingoDeckViewController!
    private var mainDeckViewController:BingoDeckViewController!
    
    private var bingoGame:BingoGame!
    
    // MARK: Initializers
    public init(bingoGame:BingoGame) {
        self.bingoGame = bingoGame
        let bundle = Bundle(for: BingoGameViewController.self)
        super.init(nibName: "BingoGameViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.bingoGame.delegate = self
        self.setupUI()
        self.updateScoreLabels()
    }
    
    // MARK: Private methods
    private func setupUI(){
        self.localPlayerDeckViewController = BingoDeckViewController(deck:self.bingoGame.players[0].assignedDeck)
        LayoutUtilities.addChild(viewController: localPlayerDeckViewController,
                                     inView: self.localPlayerViewContainer,
                                     parentViewController: self)
        
        self.mainDeckViewController = BingoDeckViewController(deck:self.bingoGame.mainDeck, delegate:self)
        LayoutUtilities.addChild(viewController: mainDeckViewController,
                                     inView: self.mainDeckViewContainer,
                                     parentViewController: self)
        
        self.remotePlayerDeckViewController = BingoDeckViewController(deck:self.bingoGame.players[1].assignedDeck)
        LayoutUtilities.addChild(viewController: remotePlayerDeckViewController,
                                     inView: self.remotePlayerViewContainer,
                                     parentViewController: self)
    }
    
    private func updateScoreLabels(){
        let localPlayer = self.bingoGame.players[0]
        self.localPlayerLabel.text = "\(localPlayer.playerId): \(localPlayer.assignedDeck.openedCards.count)"
        let remotePlayer = self.bingoGame.players[1]
        self.remotePlayerLabel.text = "\(remotePlayer.playerId): \(remotePlayer.assignedDeck.openedCards.count)"
    }

}

extension BingoGameViewController:BingoGameDelegate{
    
    public func bingoGameDidStart(_ game: BingoGame) {
        
    }
    
    public func bingoGame(_ game: BingoGame, cardOpened: BingoCard) {
        self.localPlayerDeckViewController.handleOpened(card:cardOpened)
        self.remotePlayerDeckViewController.handleOpened(card:cardOpened)
        self.updateScoreLabels()
    }
    
    public func bingoGame(_ game: BingoGame, deckCompleted byPlayer: BingoPlayer) {
        print("Player '\(byPlayer.playerId)' completed deck!")
        self.bingoGame.printGameStatus()
    }
    
}

extension BingoGameViewController:BingoDeckViewControllerDelegate{

    func bingoDeck(_ bingoDeckViewController: BingoDeckViewController, cardOpened: BingoCard) {
        if let cardIndex = self.bingoGame.mainDeck.cards.index(of:cardOpened){
            self.bingoGame.openCard(atIndex: cardIndex)
        } else {
            print("Card was not found in deck!!!")
            assert(false)
        }
    }
    
}
