//
//  ViewController.swift
//  SliceDiscountApp
//
//  Created by Shubhang Dixit on 01/11/20.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TappableCardsProtocol {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let homeScreenValues = HomeScreenValues()
    var observer: NSKeyValueObservation?
    var finishedLoadingInitialTableCells = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIELements()
        initialiseTableView()
    }
    
    func configureUIELements() {
        topView.setCorners(withRadius: homeScreenValues.topViewCornerRadius)
        headerLabel.text = homeScreenValues.topViewMessage
        self.view.addGradientView(withColors: homeScreenValues.gradientColors)
    }
    
    func initialiseTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        finishedLoadingInitialTableCells = false
        
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        var lastInitialDisplayableCell = false
        
        if BusinessManager.shared.getNumberOfRors() > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.section == indexPath.section {
                lastInitialDisplayableCell = true
            }
        }

        if !finishedLoadingInitialTableCells {

            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }

            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: 130)
            cell.alpha = 0

            UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.section), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
    
    // MARK: - TappableCardsProtocol methods
    
    func didTapOnCard(atIndexPath indexPath: PromoIndexPath) {
        showDetailsForPromo(atIndexPath: indexPath)
    }
    
    func showDetailsForPromo(atIndexPath indexpath : PromoIndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: PromoDetailsViewController.className) as? PromoDetailsViewController {
            vc.promoIndexPath = indexpath
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

