//
//  ViewController.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let homeScreenValues = HomeScreenValues()
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIELements()
        initialiseTableView()
    }
    
    func configureUIELements() {
        topView.setCorners(withRadius: homeScreenValues.topViewCornerRadius)
        headerLabel.text = homeScreenValues.topViewMessage
    }
    
    func initialiseTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        observer = BusinessManager.shared.observe(\.discountsData, options: [], changeHandler: { [weak self](object, change) in
            self?.tableView.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        BusinessManager.shared.getNumberOfRors()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscountsListTableViewCell.className) as! DiscountsListTableViewCell
        cell.setupCellContents(withData: BusinessManager.shared.getDiscountData(forRow: indexPath.row), andCellIndex: indexPath.row)
        return cell
    }
    

}

