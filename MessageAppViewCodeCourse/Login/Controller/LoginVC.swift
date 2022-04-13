//
//  ViewController.swift
//  LoginRegisterScreen-Course
//
//  Created by Jean Lucas Vitor on 06/04/22.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    var loginScreen: LoginScreen?
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.delegate(delegate: self)
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.loginScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension LoginVC: LoginScreenProtocol {
    func actionLoginButton() {
        guard let login = loginScreen else { return }
        
        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { (usuario, error) in
            if error != nil {
                self.alert?.getALert(title: "Atenção", message: "Dados incorretos! Verifique e tente novamente.")
            } else {
                if usuario == nil {
                    self.alert?.getALert(title: "Atenção", message: "Tivemos um problema inesperado, tente novamente mais tarde.")
                } else {
                    let vc = HomeVC()
                    let navVc = UINavigationController(rootViewController: vc)
                    navVc.modalPresentationStyle = .fullScreen
                    self.present(navVc, animated: true, completion: nil)
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let viewController: RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
