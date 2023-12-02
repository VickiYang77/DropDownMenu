//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Vicki Yang on 2023/12/2.
//

import UIKit

class ViewController: UIViewController {
    
    let colors: [String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dropDownMenuTap(_ sender: Any) {
        let vc = DropDownMenuCollectionViewController(items: colors) { (cell, item) in
            cell.titleLabel.text = item
        }
        present(vc, animated: true)
    }
}

