//
//  RegisterViewController.swift
//  LoginRegisterScreen-Course
//
//  Created by Jean Lucas Vitor on 06/04/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    var registerScreen: RegisterScreen?
    var auth: Auth?
    var firestore: Firestore?
    var alert: Alert?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.alert = Alert(controller: self)
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validaTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterVC: RegisterScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionregisterButton() {
        guard let register = self.registerScreen else { return }
        
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { (result, error) in
            if error != nil {
                self.alert?.getALert(title: "Atenção", message: "Erro ao cadastrar, verifique os dados e tente novamente.")
            } else {
                //Salvar dados no firebase
                if let idUsuario = result?.user.uid {
                    self.firestore?.collection("usuarios").document(idUsuario).setData([
                        "nome": self.registerScreen?.getName() ?? "",
                        "email": self.registerScreen?.getEmail() ?? "",
                        "id": idUsuario
                    ])
                }
                self.alert?.getALert(title: "Parabéns", message: "Usuário cadastrado com sucesso", completion: {
                    let vc = HomeVC()
                    let navVc = UINavigationController(rootViewController: vc)
                    navVc.modalPresentationStyle = .fullScreen
                    self.present(navVc, animated: true, completion: nil)
                })
            }
        })
        
    }
}
