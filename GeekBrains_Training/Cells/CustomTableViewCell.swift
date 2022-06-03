//
//  CustomTableViewCell.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 31.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
//    override func prepareForReuse() {
//        imageCellView.image = nil
//        titleLabel = nil
//    }
    
    func configure(friend: Friend) {
        imageCellView.image = friend.avatar
        titleLabel?.text = friend.name
    }
    
    func configure(group: Group) {
        imageCellView.image = group.avatar
        titleLabel?.text = group.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        imageCellView.addGestureRecognizer(tapGR)
        imageCellView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(withDuration: 0.2) {
                self.imageCellView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            } completion: { _ in
                UIView.animate(withDuration: 0.3,
                               delay: 0.2,
                               usingSpringWithDamping: 0.2,
                               initialSpringVelocity: 10,
                               options: .curveEaseOut) {
                    self.imageCellView.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        }
    }
}
