//
//  DropDownMenuCollectionViewController.swift
//  DropDownMenu
//
//  Created by Vicki Yang on 2023/12/2.
//

import UIKit

class DropDownMenuCollectionViewController<T>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var items: [T]
    var configureCell: (DropDownMenuCell, T) -> Void
    var selectHandler: ((Int) -> Void)?
    
    init(items: [T], configureCell: @escaping (DropDownMenuCell, T) -> Void, selectHandler: ((Int) -> Void)? = nil) {
        self.items = items
        self.configureCell = configureCell
        self.selectHandler = selectHandler
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0 // 左右間距
        layout.minimumLineSpacing = 7 // 上下間距
        super.init(collectionViewLayout: layout)
        
        collectionView.backgroundColor = .yellow
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView!.register(DropDownMenuCell.self, forCellWithReuseIdentifier: DropDownMenuCell.identifier)
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
        
        DispatchQueue.main.async {
            self.dismiss(animated: true) {[weak self] in
                self?.selectHandler?(indexPath.row)
            }
        }
    }
    
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.frame.width - 5) / 3)
        return CGSize(width: width, height: 50)
    }
}
