//
//  ViewController.swift
//  AnnotateView
//
//  Created by Mallikarjun Patil on 2/4/17.
//  Copyright © 2017 Mallikarjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(drawView)
        
    }
}

