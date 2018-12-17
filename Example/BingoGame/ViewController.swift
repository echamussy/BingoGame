//
//  ViewController.swift
//  BingoGame
//
//  Created by echamussy on 12/14/2018.
//  Copyright (c) 2018 echamussy. All rights reserved.
//

import UIKit
import BingoGame

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let podBundle = Bundle(for:BingoViewController.self)
        let bingoViewController = BingoViewController(nibName: "BingoViewController", bundle: podBundle)
        self.present(bingoViewController, animated: false, completion: nil)
    }
}

