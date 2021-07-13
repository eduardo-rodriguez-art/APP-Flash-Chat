//
//  ChatViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 04/07/21.
//

import UIKit
import Firebase

enum ProviderType: String {
    case basic
}

class ChatViewController: UIViewController {

    @IBOutlet weak var sendMessageText: UITextField!
    @IBOutlet weak var myTable: UITableView!
    
    private let email: String
    private let provider: ProviderType
    var welcome = WelcomeViewController()
    
    init(email: String, provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // tal vez lo quite
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        print(email)
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }


    @IBAction func sendMessagePressed(_ sender: UIButton) {
        cerrar()
    }
    
    private func cerrar(){
        switch provider {

        case .basic:
            do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
            }catch {
                print("Algun error")
            }
        }
    }
}
