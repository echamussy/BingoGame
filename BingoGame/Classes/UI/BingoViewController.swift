//
//  BingoViewController.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 17/12/2018.
//

import UIKit

public class BingoViewController: UIViewController {

    @IBOutlet weak var localPlayerViewContainer: UIView!
    @IBOutlet weak var mainDeckViewContainer: UIView!
    @IBOutlet weak var remotePlayerViewContainer: UIView!
    @IBOutlet weak var localPlayerLabel: UILabel!
    @IBOutlet weak var remotePlayerLabel: UILabel!
    
    private var localPlayerDeckViewController:BingoDeckViewController!
    private var remotePlayerDeckViewController:BingoDeckViewController!
    private var mainDeckViewController:BingoDeckViewController!
    
    private var bingoGame:BingoGame!
    private var gameConfiguration:BingoGameConfiguration
    
    // MARK: Initializers
    public init(gameConfiguration:BingoGameConfiguration) {
        self.gameConfiguration = gameConfiguration
        let bundle = Bundle(for: BingoViewController.self)
        super.init(nibName: "BingoViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGame()
        self.setupUI()
        self.updateScoreLabels()
    }
    
    // MARK: Private methods
    private func setupUI(){
        self.localPlayerDeckViewController = BingoDeckViewController(deck:self.bingoGame.players[0].assignedDeck)
        BingoViewController.addChild(viewController: localPlayerDeckViewController,
                                     inView: self.localPlayerViewContainer,
                                     parentViewController: self)
        
        self.mainDeckViewController = BingoDeckViewController(deck:self.bingoGame.mainDeck, delegate:self)
        BingoViewController.addChild(viewController: mainDeckViewController,
                                     inView: self.mainDeckViewContainer,
                                     parentViewController: self)
        
        self.remotePlayerDeckViewController = BingoDeckViewController(deck:self.bingoGame.players[1].assignedDeck)
        BingoViewController.addChild(viewController: remotePlayerDeckViewController,
                                     inView: self.remotePlayerViewContainer,
                                     parentViewController: self)

    }
    
    private func setupGame(){
        self.bingoGame = BingoGame(configuration: self.gameConfiguration, delegate:self)
        self.bingoGame.startGame()
    }
    
    private func updateScoreLabels(){
        let localPlayer = self.bingoGame.players[0]
        self.localPlayerLabel.text = "\(localPlayer.playerId): \(localPlayer.assignedDeck.openedCards.count)"
        let remotePlayer = self.bingoGame.players[1]
        self.remotePlayerLabel.text = "\(remotePlayer.playerId): \(remotePlayer.assignedDeck.openedCards.count)"
    }
    
    
    // MARK: Static methods - GET OUT OF HERE AND USE OUR SHARED CLASS!
    
    static func addConstraintsTo(parentView:UIView, childView:UIView){
        
        let topConstraint = NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: childView, attribute: .trailing, relatedBy: .equal, toItem: parentView, attribute: .trailing, multiplier: 1, constant: 0)
        
        parentView.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        parentView.layoutIfNeeded()
        
    }
    
    static func addChild(viewController:UIViewController, inView:UIView, parentViewController:UIViewController){
        
        let childView = viewController.view!
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        parentViewController.addChild(viewController)
        inView.addSubview(childView)
        viewController.didMove(toParent: parentViewController)
        BingoViewController.addConstraintsTo(parentView: inView,
                                         childView: childView)
        
    }

}

extension BingoViewController:BingoGameDelegate{
    
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

extension BingoViewController:BingoDeckViewControllerDelegate{

    func bingoDeck(_ bingoDeckViewController: BingoDeckViewController, cardOpened: BingoCard) {
        if let cardIndex = self.bingoGame.mainDeck.cards.index(of:cardOpened){
            self.bingoGame.openCard(atIndex: cardIndex)
        } else {
            print("Card was not found in deck!!!")
            assert(false)
        }
    }
    
}
