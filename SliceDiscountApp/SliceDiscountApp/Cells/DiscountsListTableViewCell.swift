//
//  DiscountsListTableViewCell.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 02/11/20.
//

import UIKit

protocol TappableCardsProtocol {
    func didTapOnCard(atIndexPath indexPath : PromoIndexPath)
}

class DiscountsListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var cellIndex : Int?
    var dataSource : [DiscountData] = []
    var delegate : TappableCardsProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellContents(withData data : [DiscountData], andCellIndex index : Int) {
        self.cellIndex = index
        self.dataSource = data
        topView.isHidden = index != 0
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let section = cellIndex {
            delegate?.didTapOnCard(atIndexPath: PromoIndexPath(withSection: section, Row: indexPath.row))
        }
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
