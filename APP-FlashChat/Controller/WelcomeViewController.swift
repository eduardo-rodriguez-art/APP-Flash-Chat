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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func registerPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    
    @IBAction func logInPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
}
