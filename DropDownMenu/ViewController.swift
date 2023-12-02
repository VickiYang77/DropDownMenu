//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Vicki Yang on 2023/12/2.
//

import UIKit

struct ColorCellModel {
    var title: String
    var color: UIColor
}

class ViewController: UIViewController {
    let rainbowColors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .systemIndigo, .purple]
    let colorNames = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"]
    lazy var colorItems = zip(rainbowColors, colorNames).map { color, name in
        return ColorCellModel(title: name, color: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dropDownMenuTap(_ sender: Any) {
        let vc = DropDownMenuCollectionViewController(items: colorItems, configureCell: { (cell, item) in
            cell.titleLabel.text = item.title
        }) { [weak self] (index, item) in
            self?.view.backgroundColor = item.color
        }

        present(vc, animated: true)
    }
}

