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

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var messageText: UITextField!
    private let email: String
    private let provider: ProviderType
    
    private var messages: [Messages] = [
        Messages(sender: "pepe@gmail.com", body: "Hello"),
        Messages(sender: "eduardo@gmail.com", body: "Hi!"),
        Messages(sender: "pepe@gmail.com", body: "How are you?")
    ]
    
    init(email: String, provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Destructor
    //deinit {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        print(email)
        self.navigationItem.hidesBackButton = true
        
        self.myTableView.dataSource = self
        //self.viewTable.delegate = self
        
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
    }


    @IBAction func sendMessagePressed(_ sender: UIButton) {
        if let message = messageText.text {
            print(message)
        }
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
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // con el as declaramos que sea de la clase de la celda
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageTableViewCell
        
        // text in the cells
        cell.nameLabel.text = messages[indexPath.row].body
        
        return cell
        /*
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ReusableCell")
        
        cell.textLabel?.text = messages[indexPath.row].body
        return cell*/
    }
    
    
}
/*
extension ChatViewController: UITableViewDelegate {
    
}*/

