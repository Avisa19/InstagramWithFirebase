//
//  CommentController.swift
//  Practice
//
//  Created by Avisa Poshtkouhi on 10/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

private let commentCell = "commentCell"

class CommentController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()


        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: commentCell)
        
        collectionView.backgroundColor = .systemBlue
        
        collectionView.alwaysBounceVertical = true

        // Do any additional setup after loading the view.
    }

 

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCell, for: indexPath)
    
        // Configure the cell
        
        cell.backgroundColor = .systemPink
    
        return cell
    }

  

}
