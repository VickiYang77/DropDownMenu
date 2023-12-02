//
//  DropDownMenuCollectionViewController.swift
//  DropDownMenu
//
//  Created by Vicki Yang on 2023/12/2.
//

import UIKit

class DropDownMenuCollectionViewController<T>: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIPopoverPresentationControllerDelegate {
    
    var items: [T]
    var configureCell: (DropDownMenuCell, T) -> Void
    var selectHandler: ((Int, T) -> Void)?
    var cellHeight: CGFloat = 50
    
    init(items: [T], configureCell: @escaping (DropDownMenuCell, T) -> Void, selectHandler: ((Int, T) -> Void)? = nil) {
        self.items = items
        self.configureCell = configureCell
        self.selectHandler = selectHandler
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0 // 左右間距
        layout.minimumLineSpacing = 7 // 上下間距
        super.init(collectionViewLayout: layout)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView!.register(DropDownMenuCell.self, forCellWithReuseIdentifier: DropDownMenuCell.identifier)
        
        // popover
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: 300, height: items.count / 3 * Int(cellHeight))
        self.popoverPresentationController?.delegate = self
//        self.po//popoverController.permittedArrowDirections = .any
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DropDownMenuCell.identifier, for: indexPath) as? DropDownMenuCell {
            let item = items[indexPath.row]
            configureCell(cell, item)
            return cell
        }
        
        return UICollectionViewCell()
    }

    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < items.count else { return }
        let item = items[indexPath.row]
        
        DispatchQueue.main.async {
            self.dismiss(animated: false) {[weak self] in
                self?.selectHandler?(indexPath.row, item)
            }
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.width - 5) / 3)
        return CGSize(width: width, height: cellHeight)
    }
    
    
    // MARK: UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        //.none 可確保 popover 在 iPad 上不會根據裝置的大小自動轉換為全螢幕 modal 形式呈現
        return .none
    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        // 返回 true 允許 popover 被取消，返回 false 則不允許
        return true
    }
}
