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
    
    private var localPlayerDeckViewController:BingoDeckViewController!
    private var remotePlayerDeckViewController:BingoDeckViewController!
    private var mainDeckViewController:BingoDeckViewController!
    
    var bingoGame:BingoGame!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGame()
        
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
    
    // MARK: Private methods
    
    private func setupGame(){
        let cardArray = BingoDeck.createCardArrayFrom(elements: ["apple", "avocado", "banana", "blackberry", "cherry", "kiwi", "orange", "pear", "pineapple", "raspberry", "strawberry", "watermelon"])
        let gameConfiguration = BingoGameConfiguration(playerIds:["Emma", "Manuel"],
                                                       availableCards:cardArray)
        self.bingoGame = BingoGame(configuration: gameConfiguration, delegate:self)
        self.bingoGame.startGame()
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
