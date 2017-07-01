//
//  MenuViewController.swift
//  TransparentView
//
//  Created by edwinbosire on 17/06/2016.
//  Copyright © 2016 Edwin Bosire. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


protocol MenuViewDelegate {
    func didSelect(_ menu: Menu, row: IndexPath, inTableView: UITableView)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: MenuViewDelegate?
    var menu: [Menu] {
        get {
            return [Menu(), Menu(title:"Map"), Menu(title:"All Alerts"), Menu(title:"More"), Menu(title:""), Menu(title:"Sign Out")]
        }
    }
    
    let cellIdentifier = "cellIdentifier"
    lazy var checkMark  = UIImageView(image: UIImage(named: "check"))
    var selected: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView () {
        tableView.reloadData()
        if tableView.indexPathsForVisibleRows?.count > 0 {
            tableView.selectRow(at: tableView!.indexPathsForVisibleRows![selected], animated: true, scrollPosition: .none)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MenuTableViewCell
        cell.menu = menu[indexPath.row]        
        if indexPath.row == 0 {
            // we could create a whole new 'spacer' cell. but I am lazy, so I wont.
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        
        if let delegate = delegate {
            let delayTime = DispatchTime.now() + Double(Int64(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) { [unowned self] in
                delegate.didSelect(self.menu[indexPath.row], row:indexPath, inTableView: tableView)
            }

        }
    }
}
