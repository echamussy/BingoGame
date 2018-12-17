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
    
    var bingoGame:BingoGame!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGame()
        
        let localPlayerDeckViewController = BingoDeckViewController(deck:self.bingoGame.players[0].assignedDeck)
        BingoViewController.addChild(viewController: localPlayerDeckViewController,
                                     inView: self.localPlayerViewContainer,
                                     parentViewController: self)
        
        let mainDeckViewController = BingoDeckViewController(deck:self.bingoGame.mainDeck)
        BingoViewController.addChild(viewController: mainDeckViewController,
                                     inView: self.mainDeckViewContainer,
                                     parentViewController: self)
        
        let remotePlayerDeckViewController = BingoDeckViewController(deck:self.bingoGame.players[1].assignedDeck)
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
        
    }
    
    public func bingoGame(_ game: BingoGame, deckCompleted byPlayer: BingoPlayer) {
        print("Player '\(byPlayer.playerId)' completed deck!")
        self.bingoGame.printGameStatus()
    }
    
    
    
}
