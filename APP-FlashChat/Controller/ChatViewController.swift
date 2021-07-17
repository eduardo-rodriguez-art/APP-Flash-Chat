//
//  ChatViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 04/07/21.
//

import UIKit
import Firebase
import GoogleSignIn

enum ProviderType: String {
    case basic
    case google
}

class ChatViewController: UIViewController {

    @IBOutlet weak var sendMessageText: UITextField!
    @IBOutlet weak var myTable: UITableView!
    
    private let email: String
    private let provider: ProviderType
    
    init(email: String, provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Destructor
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        print(email)
        self.navigationItem.hidesBackButton = true
        
        self.myTable.dataSource = self
    }


    @IBAction func sendMessagePressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func LogOut(_ sender: UIButton) {
        self.closeForProvider()
    }
    
    private func closeForProvider(){
        //  al cerrar sesion aseguramos que se elimine la persistencia de datos
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        switch provider {

        case .basic:
            self.firebaseLogOut()
        case .google:
            GIDSignIn.sharedInstance()?.signOut()
            self.firebaseLogOut()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func firebaseLogOut() {
        do {
            try Auth.auth().signOut()
            
        }catch {
            print("Algun error")
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
