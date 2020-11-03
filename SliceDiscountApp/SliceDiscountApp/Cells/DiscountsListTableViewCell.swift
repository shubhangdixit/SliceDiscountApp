//
//  DiscountsListTableViewCell.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 02/11/20.
//

import UIKit

class DiscountsListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource : [DiscountData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellContents(withData data : [DiscountData], andCellIndex index : Int) {
        self.dataSource = data
        topView.isHidden = index != 0
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//       // let width = UIScreen.main.bounds.width
//        layout.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20)
//
//        layout.itemSize = CGSize(width: 131, height: 210)
//        layout.scrollDirection = .horizontal
//        //layout.minimumInteritemSpacing = 20
//     // layout.minimumLineSpacing = 20
//        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountCardsCollectionViewCell.className, for: indexPath) as! DiscountCardsCollectionViewCell
        cell.setUpCards(withData: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 131, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
