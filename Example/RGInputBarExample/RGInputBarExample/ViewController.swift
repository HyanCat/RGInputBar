//
//  ViewController.swift
//  RGInputBarExample
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017 ruogoo. All rights reserved.
//

import UIKit
import RGInputBar

class ViewController: UIViewController {

    private let _inputBarController: RGInputBarController = RGInputBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_inputBarController.view)
    }

}

