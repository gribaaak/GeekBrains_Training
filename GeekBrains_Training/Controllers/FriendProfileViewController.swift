//
//  FriendProfileViewController.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 05.05.2022.
//

import UIKit

class FriendProfileViewController: UIViewController {
    
    @IBOutlet weak var LikeController: LikeControl!
    
    @IBOutlet weak var backImageProfile: UIView!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    
    var friendAvatar = UIImage()
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LikeController.addTarget(self, action: #selector(likeControlChange), for: .valueChanged)
    }
    
    @objc private func likeControlChange() {
        LikeController.setNeedsDisplay()
    }
    
    override func viewWillLayoutSubviews() {
        imageProfile.image = friendAvatar
        
//        imageProfile.layer.borderColor = UIColor.lightGray.cgColor
//        imageProfile.layer.borderWidth = 4
        imageProfile.layer.cornerRadius = 100
        
        backImageProfile.layer.cornerRadius = 100
        backImageProfile.layer.shadowColor = UIColor.black.cgColor
        backImageProfile.layer.shadowOpacity = 1
        backImageProfile.layer.shadowOffset = .zero
        backImageProfile.layer.shadowRadius = 5
        
        nameProfile.text = name
    }
}
