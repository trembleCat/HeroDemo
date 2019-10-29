//
//  MainViewController.swift
//  HeroTest
//
//  Created by FDM on 2019/10/17.
//  Copyright © 2019 发抖喵. All rights reserved.

/**首页，不需要看*/

import UIKit
import Hero

class MainViewController: UIViewController {
    
    let titleArray: Array<String> = [
        "简单实例1",
        "简单实例2",
        "简单实例3"
    ]
    
    let viewControllerArray: Array<UIViewController> = [
        ViewController_1A(),
        ViewController_2A(),
        ViewController_3A()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: self.view.bounds.width - 30, height: 70)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension MainViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 5
        cell.layer.shadowOffset = CGSize(width: 3, height: 5)
        
        let titleLabel = UILabel()
        titleLabel.text = self.titleArray[indexPath.item]
        titleLabel.frame = CGRect(x: 50, y: 0, width: 100, height: 70)
        cell.contentView.addSubview(titleLabel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.viewControllerArray[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

