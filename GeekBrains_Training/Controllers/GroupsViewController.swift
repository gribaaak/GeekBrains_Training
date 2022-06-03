//
//  GroupsViewController.swift
//  MinibaevArtur_UI
//
//  Created by Artur Minibaev on 31.10.2021.
//

import UIKit

class GroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    
    var groupsArray = [Group]()
    
    func fillGroupsArray() {
        let groupApplicationIdeas = Group(title: "Application ideas", avatar: UIImage(named: "Application ideas")!)
        let groupIntertainment = Group(title: "Intertainment", avatar: UIImage(named: "Intertainment")!)
        let groupLearningGB = Group(title: "Learning GB", avatar: UIImage(named: "Learning GB")!)
        let groupPlacesToTravel = Group(title: "Places to travel", avatar: UIImage(named: "Places to travel")!)
        let groupPolitics = Group(title: "Politics", avatar: UIImage(named: "Politics")!)
        let groupWork = Group(title: "Work", avatar: UIImage(named: "Work")!)
        groupsArray.append(groupApplicationIdeas)
        groupsArray.append(groupIntertainment)
        groupsArray.append(groupLearningGB)
        groupsArray.append(groupPlacesToTravel)
        groupsArray.append(groupPolitics)
        groupsArray.append(groupWork)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillGroupsArray()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: groupsArray[indexPath.row])
        return cell
    }
}
