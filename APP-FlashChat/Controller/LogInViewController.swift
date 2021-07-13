//
//  LogInViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 04/07/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inicio de sesion"
    }

    @IBAction func logInPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let result = result, error == nil {
                    self.navigationController?.pushViewController(ChatViewController(email: result.user.email!, provider: .basic), animated: true)
                }
                // caso de error
                else {
                    let alert = UIAlertController(title: "Error", message: "Se ha producido un error al registar el usuario", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
