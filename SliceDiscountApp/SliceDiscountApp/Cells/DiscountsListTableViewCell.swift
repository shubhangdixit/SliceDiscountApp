//
//  DiscountsListTableViewCell.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 02/11/20.
//

import UIKit

class DiscountsListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource : [DiscountData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellContents(withData data : [DiscountData], andCellIndex index : Int) {
        self.dataSource = data
        topView.isHidden = index == 0
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountCardsCollectionViewCell.className, for: indexPath) as! DiscountCardsCollectionViewCell
        cell.setUpCards(withData: dataSource[indexPath.row])
        return cell
    }
    

}
