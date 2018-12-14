//
//  ViewController.swift
//  FloatingSkeletonTableView
//
//  Created by 山田良治 on 2018/12/15.
//  Copyright © 2018 山田良治. All rights reserved.
//

import UIKit
import SkeletonView
import Kingfisher

class FloatingSkeletonTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let cellIdentifer = "FloatingSkeletonTableViewCell"
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    private var movies: [Movie] = []
    private let client = ITunesClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: cellIdentifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        
        client.fetchTopMovies { [weak self] movies in
            self?.movies = movies
            
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.hideSkeleton()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.showAnimatedGradientSkeleton()
    }

}

extension FloatingSkeletonTableViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! FloatingSkeletonTableViewCell
        let movie = movies[indexPath.row]
        configureCell(cell, fromMovie: movie)
        return cell
    }
    
    private func configureCell(_ cell: FloatingSkeletonTableViewCell, fromMovie movie: Movie) {
        cell.delegate = self
        cell.leftImageVIew?.kf.setImage(with: movie.thumbnailURL)
        cell.rightLabel.text = movie.description
    }
    
}

extension FloatingSkeletonTableViewController: SkeletonTableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension FloatingSkeletonTableViewController: FloatingSkeletonTableViewCellDelegate {
    
    func cellWillStartAnimating() {
        feedbackGenerator.prepare()
    }
    
    func cellWillEndAnimating() {
        feedbackGenerator.impactOccurred()
    }
    
}
