//
//  ViewController.swift
//  FloatingSkeletonTableView
//
//  Created by 山田良治 on 2018/12/15.
//  Copyright © 2018 山田良治. All rights reserved.
//

import UIKit
import SkeletonView

class FloatingSkeletonTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifer = "FloatingSkeletonTableViewCell"
    let numberOfRows = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.showAnimatedGradientSkeleton()
    }

}

extension FloatingSkeletonTableViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! FloatingSkeletonTableViewCell
        return cell
    }
    
}

extension FloatingSkeletonTableViewController: SkeletonTableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
