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
    /// Creates a new data base
    let db = Firestore.firestore()
    
    private var messages: [Messages] = []
    
    init(email: String, provider: ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Destructor
    deinit {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        print(email)
        self.navigationItem.hidesBackButton = true
        
        self.myTableView.dataSource = self
        //self.viewTable.delegate = self
        // creates a NIB
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        
        // se llama aqui porque leyo los datos, y se deben ver en la tabla
        self.loadMessages()
    }
    
    /* // documentation from firebase -> Manage User
     if Auth.auth().currentUser != nil {
       // User is signed in.
     } else {
       // No user is signed in.}
     verificamos que el usuario este registrado */

    // Create a new collection and a document
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        if let messageBody = messageText.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue \(e)")
                }else {
                    print("Succesfully data saved")
                }
            }
        }
        messageText.text = ""
    }
    /*
     Actualizar las reglas en la base de datos
     para que solo los que esten registrados vean los mensajes*/
    /// Function that retrieving the information from database
    private func loadMessages() {
        
        /* addSnapshotListener sustituyo a .getDocuments porque
          de esta forma se actualiza si se envian mas cosas al backend
         .order ordena de acuerdo a la hora que devuelve timeIntervalSince1970*/
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
                self.messages = []
            
            if let er = error {
                print("there was an issue retrieving data \(er) ")
            } else { // there was nothing error
                
                let _ = querySnapshot?.documents.map({
                    (document) in
                    let data = document.data()
                    // cast with as? because this dictionary returns an Any
                    // data is a diccionary with key: String and Value: Any
                    if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                        let newMessage = Messages(sender: messageSender, body: messageBody)
                        self.messages.append(newMessage)
                        // Update the table-> but this function is waiting an answer:
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                    }
                })
            }
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

//MARK: - UITableViewDataSource
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
