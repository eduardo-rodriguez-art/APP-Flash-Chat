//
//  LogInViewController.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 04/07/21.
//

import UIKit
import Firebase
import GoogleSignIn

class LogInViewController: UIViewController {

    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inicio de sesion"
        
        // Comprobar la sesion del usuario atenticado
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String, let provider = defaults.value(forKey: "provider") as? String{
            self.authStackView.isHidden = true
            self.navigationController?.pushViewController(ChatViewController(email: email, provider: ProviderType.init(rawValue: provider)!), animated: false)
        }
        defaults.synchronize()
        
        // Google Auth -> se presenta la pantalla donde estan tus correos
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.authStackView.isHidden = false
    }

    // inicio de sesion normal
    // pepe@gmail.com  pepelalo and pepe24@gmail.com
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
    
    
    @IBAction func googleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
//    esta funcion me despliega error al autenticar google
    private func showHome(result: AuthDataResult?, error: Error?, provider: ProviderType){
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                // There is no an error
                if let result = result, error == nil {
                    self.navigationController?.pushViewController(ChatViewController(email: result.user.email!, provider: provider), animated: true)
                }
                // en caso de que exista un error
                else {
                    let alert = UIAlertController(title: "Error", message: "Se ha producido un error de autenticacion en \(provider.rawValue)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

//MARK: - GIDSignInDelegate
extension LogInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error == nil && user.authentication != nil {
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            Auth.auth().signIn(with: credential) { (result, error) in
                // aqui puede ser que se despliega ese error
                self.showHome(result: result, error: error, provider: .google)
            }
        }
    }
}
