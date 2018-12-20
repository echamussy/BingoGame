//
//  LayoutUtilities.swift
//  BingoGame
//
//  Created by Enrique Rodriguez on 19/12/2018.
//

import Foundation

// TODO: Instad of duplicating this code with other projects we should create a Utilities pod that incorporates this class

class LayoutUtilities{
    
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
        LayoutUtilities.addConstraintsTo(parentView: inView,
                                         childView: childView)
        
    }
    
}
