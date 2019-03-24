//
//  ViewController.swift
//  RGInputBarExample
//
//  Created by HyanCat on 29/05/2017.
//  Copyright © 2017 ruogoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RGInputBarControllerDelegate {

    private let _inputBarController: RGInputBarController = RGInputBarController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(_inputBarController.view)

        _inputBarController.delegate = self
        _inputBarController.inputBar?.icons = [UIImage(named: "gift")!, UIImage(named: "like")!];
    }

    @IBAction func atButtonTouched(_ sender: Any) {
        _inputBarController.atUserName = "@xiaoming"
    }

    func rg_inputBarController(_ controller: RGInputBarController, didSendInput content: String?) {
        if let content = content {
            print("confirm: \(content)")
        } else {
            print("confirm empty.")
        }
    }
}

