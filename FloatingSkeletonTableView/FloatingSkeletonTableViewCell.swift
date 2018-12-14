//
//  FloatingSkeletonTableViewCell.swift
//  FloatingSkeletonTableView
//
//  Created by 山田良治 on 2018/12/15.
//  Copyright © 2018 山田良治. All rights reserved.
//

import UIKit

class FloatingSkeletonTableViewCell: UITableViewCell {
    @IBOutlet weak var floatingView: UIView!
    @IBOutlet weak var leftImageVIew: UIImageView!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initialize()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initialize() {
        floatingView.layer.cornerRadius = 3
    }
    
}
