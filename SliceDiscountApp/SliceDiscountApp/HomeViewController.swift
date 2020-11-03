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
        addGradientView(withFrame: self.view.bounds, Colors: homeScreenValues.gradientColors)
    }
    
    func initialiseTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        observer = BusinessManager.shared.observe(\.discountsData, options: [], changeHandler: { [weak self](object, change) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        BusinessManager.shared.getNumberOfRors()    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return homeScreenValues.cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscountsListTableViewCell.className) as! DiscountsListTableViewCell
        cell.setupCellContents(withData: BusinessManager.shared.getDiscountData(forRow: indexPath.section), andCellIndex: indexPath.section)
        return cell
    }
    

}

