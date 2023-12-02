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
    let colorItems = [
        ColorCellModel(title: "Red", color: .red),
        ColorCellModel(title: "Orange", color: .orange),
        ColorCellModel(title: "Yellow", color: .yellow),
        ColorCellModel(title: "Green", color: .green),
        ColorCellModel(title: "Blue", color: .blue),
        ColorCellModel(title: "Indigo", color: .systemIndigo),
        ColorCellModel(title: "Violet", color: .purple)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dropDownMenuTap(_ sender: UIButton) {
        let dropDownMenuVC = DropDownMenuCollectionViewController(items: colorItems, configureCell: { (cell, item) in
            cell.titleLabel.text = item.title
            cell.titleLabel.textColor = item.color
            cell.titleLabel.font = .systemFont(ofSize: 20)
        }) { [weak self] (index, item) in
            self?.view.backgroundColor = item.color
        }
        
        if let popoverPresentationController = dropDownMenuVC.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .up
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
        }
        
        present(dropDownMenuVC, animated: true)
    }
}

