//
//  WelcomeViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 01/07/21.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        self.titleLabel.text = "⚡️FlashChat"
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
    @IBAction func logInPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
}
