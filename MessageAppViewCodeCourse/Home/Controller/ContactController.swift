//
//  ContactController.swift
//  MessageAppViewCodeCourse
//
//  Created by Jean Lucas Vitor on 13/04/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContactProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func succesContact()
}

class ContactController {
    
    weak var delegate: ContactProtocol?
    
    public func delegate(delegate: ContactProtocol?) {
        self.delegate = delegate
    }
    
    func addContact(email: String, emailUsuarioLogado: String, idUsuario: String) {
        
        if email == emailUsuarioLogado {
            self.delegate?.alertStateError(title: "Você adicionou seu próprio email", message: "Adicione um email diferente")
            return
        }
        
        //Verifica se existe o usuario no firebase
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { snapshotResult, error in
            
            //Conta total de retorno
            if let totalItems = snapshotResult?.count {
                if totalItems == 0 {
                    self.delegate?.alertStateError(title: "Usuário não cadastrado", message: "Verifique o email e tente novamente")
                    return
                }
            }
            
            //Salvar contato
            if let snapshot = snapshotResult {
                snapshot.documents.forEach { document in
                    let dados = document.data()
                    self.salvarContato(dadosContato: dados, idUsuario: idUsuario)
                }
            }
        }
        
    }
    
    func salvarContato(dadosContato: [String: Any], idUsuario: String) {
        let contact: Contact = Contact(dicionario: dadosContato)
        let firestore: Firestore = Firestore.firestore()
        firestore.collection("usuarios").document(idUsuario).collection("contatos").document(contact.id ?? "").setData(dadosContato) {(error) in
            if error == nil {
                self.delegate?.succesContact()
            }
        }
    }
    
}
