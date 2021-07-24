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
        self.titleLabel.text = K.nameApp
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // desaparece la barra de navegacion
        // pero la desaparece de todos los controladores
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // se recupera la barra de navegacion y se sigue mostrando en los demas controladores
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
    @IBAction func logInPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
}
