//
//  NewsTableViewCell.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 09.05.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeControl: LikeControl!
    
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var numberOfLikes: UILabel!
    
    func configure(news: Articles) {
        if let urlS: String = news.urlToImage {
            if let url = URL(string: urlS){
                imageViewCell.load(url: url)
            }
        } else {
            imageViewCell.image = UIImage(named: "news")
        }
        name.text = news.source?.name
        titleLabel?.text = news.title
        dateLabel.text = timeFormat(news.publishedAt)
    }
    
    func timeFormat(_ str: String?) -> String {
        var date: String = ""
        var time: String = ""
        
        if str != nil {
            date = String(str![..<str!.firstIndex(of: "T")!])
            date = date.replacingOccurrences(of: "-", with: ".")
            
            time  = String(str![str!.index(str!.startIndex, offsetBy: 11)..<str!.lastIndex(of: ":")!])
            let dateTime = date + " " + time
            
            return dateTime
        } else {
            return ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewCell.contentMode = .scaleAspectFill
        imageViewCell.frame = self.viewCell.bounds
        imageViewCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
//        imageViewCell.layer.cornerRadius = 20
        
//        backgroundViewCell.layer.cornerRadius = 10
//        backgroundViewCell.layer.shadowColor = UIColor.black.cgColor
//        backgroundViewCell.layer.shadowOpacity = 0.2
//        backgroundViewCell.layer.shadowOffset = .zero
//        backgroundViewCell.layer.shadowRadius = 5
        
        logoImage.image = UIImage(named: "socials")
        
        logoImage.layer.cornerRadius = 25
    
        logoView.layer.cornerRadius = 25
        
        self.viewCell.addSubview(imageViewCell)
                
        likeControl.addTarget(self, action: #selector(likeControlChange), for: .valueChanged)
    }
    
    @objc private func likeControlChange() {
        //changeNumberOfLike()
        likeControl.setNeedsDisplay()
        animationNumberOfLikes()
        changeNumberOfLike()
    }
    
    func changeNumberOfLike() {
        if let stringNumberOfLikes: String = numberOfLikes.text {
            var intNumberOfLikes = 0
            if let intVar = Int(stringNumberOfLikes) {
                intNumberOfLikes = intVar
            }
            if !likeControl.filled {
                if intNumberOfLikes != 0 {
                    numberOfLikes.text = String(intNumberOfLikes - 1)
                }
            } else {
                numberOfLikes.text = String(intNumberOfLikes + 1)
            }
        }
    }
    
    func animationNumberOfLikes() {
        UIView.animate(withDuration: 0.5) {
            self.numberOfLikes.layer.opacity = 0
            self.numberOfLikes.layer.opacity = 1
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
