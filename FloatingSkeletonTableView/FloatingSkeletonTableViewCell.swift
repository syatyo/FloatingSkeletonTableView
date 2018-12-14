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
    
    private let longPress = UILongPressGestureRecognizer()
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
        floatingView.layer.cornerRadius = 5
        longPress.addTarget(self, action: #selector(handleLongPress(recognizer:)))
        longPress.minimumPressDuration = 0.01
        longPress.delegate = self
        addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        animateView()
    }
    
    private func animateView() {
        switch longPress.state {
        case .began:
            shrink()
        case .ended:
            restore()
        default:
            print("Do nothing.")
        }
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == longPress && otherGestureRecognizer.view is UIScrollView {
            return true
        }
        return false
    }
    
}

// MARK: - Animations
extension FloatingSkeletonTableViewCell {
    
    private func shrink() {
        let animationScale: CGFloat = 0.95
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.transform = .init(scaleX: animationScale,
                                   y: animationScale)
        }
    }
    
    private func expand() {
        let animationScale: CGFloat = 1.05
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.transform = .init(scaleX: animationScale,
                                   y: animationScale)
        }
    }
    
    private func restore() {
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: { [unowned self] in
                        self.transform = CGAffineTransform.identity
        })
    }

}
