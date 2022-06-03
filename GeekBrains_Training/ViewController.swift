//
//  ViewController.swift
//  GeekBrains_Training
//
//  Created by Artur Minibaev on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let networkManager = NewsNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let userName = textFieldUserName.text,
              let password = textFieldPassword.text
        else {return}
        
//        if userName == "root",
//           password == "root" {
            performSegue(withIdentifier: "toMainScreen", sender: nil)
//        } else {}
    }
}


