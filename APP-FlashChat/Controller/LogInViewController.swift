//
//  LogInViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 04/07/21.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inicio de sesion"
    }

    @IBAction func logInPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(ChatViewController(), animated: true)
    }
    
}
