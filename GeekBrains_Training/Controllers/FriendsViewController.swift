//
//  FriendsViewController.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 31.10.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    
    var friendsArray: [Friend] = [
        Friend(name: "Alex", avatar: UIImage(named: "Alex")!, photos: [UIImage(named: "Alex")!]),
        Friend(name: "Eduard", avatar: UIImage(named: "Eduard")!, photos: [UIImage(named: "Eduard")!]),
        Friend(name: "Ivan", avatar: UIImage(named: "Ivan")!, photos: [UIImage(named: "Ivan")!]),
        Friend(name: "Elza", avatar: UIImage(named: "Elza")!, photos: [UIImage(named: "Elza")!])
    ]
    
    var friendsSorted = [Character: [Friend]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.friendsSorted = sort(friends: friendsArray)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFriendProfile",
           let destinationVC = segue.destination as? FriendProfileViewController,
           let friend = sender as? Friend {
            destinationVC.friendAvatar = friend.avatar
            destinationVC.name = friend.name
        }
    }
    
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        var friendsSorted = [Character: [Friend]]()
        
        friends.forEach() { friend in
            guard let firstChar = friend.name.first else {return}
            
            if var thisCharFriend = friendsSorted[firstChar] {
                thisCharFriend.append(friend)
                friendsSorted[firstChar] = thisCharFriend
            } else {
                friendsSorted[firstChar] = [friend]
            }
        }
        return friendsSorted
    }
}


extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsSorted.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keysSorted = friendsSorted.keys.sorted()
        let friends = friendsSorted[keysSorted[section]]?.count ?? 0
        
        return friends
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(friend: friendsArray[indexPath.row])
        
        let firstChar = friendsSorted.keys.sorted()[indexPath.section]
        let friends =  friendsSorted[firstChar]!
        
        let friend: Friend = friends[indexPath.row]
        
        cell.imageCellView.image = friend.avatar
        cell.titleLabel.text = friend.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toFriendProfile", sender: friendsArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(friendsSorted.keys.sorted()[section])
    }
}
