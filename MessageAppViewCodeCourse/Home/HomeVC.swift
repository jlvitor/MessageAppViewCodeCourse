//
//  HomeVC.swift
//  MessageAppViewCodeCourse
//
//  Created by Jean Lucas Vitor on 12/04/22.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    var idUsuarioLogado: String?
    
    var screenContact: Bool?
    var emailUsuarioLogado: String?
    var alert: Alert?
    
    var screen: HomeScreen?
    
    var contact: ContactController?
    var listOfContact: [Contact] = []
    var listOfMessages: [Conversation] = []
    var messagesListener: ListenerRegistration?
    
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.configContact()
        self.addListenerRecuperarConversa()
    }
    
    private func configHomeView() {
        self.screen?.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        self.screen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        self.alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //Recuperar id usuario logado
        if let currentUser = auth?.currentUser {
            self.idUsuarioLogado = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
        }
    }
    
    private func configContact() {
        self.contact = ContactController()
        self.contact?.delegate(delegate: self)
    }
    
    private func addListenerRecuperarConversa() {
        
        if let idUsuarioLogado = auth?.currentUser?.uid {
            self.messagesListener = db?.collection("conversas").document(idUsuarioLogado).collection("ultimas_conversas").addSnapshotListener({ querySnapshot, error in
                
                if error == nil {
                    self.listOfMessages.removeAll()
                    
                    if let snapshot = querySnapshot {
                        snapshot.documents.forEach { document in
                            let dados = document.data()
                            self.listOfMessages.append(Conversation(dicionario: dados))
                        }
                        self.screen?.reloadCollectionView()
                    }
                }
            })
        }
    }
    
    func getContact() {
        self.listOfContact.removeAll()
        self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "").collection("contatos").getDocuments(completion: { snapshotResult, error in
            
            if error != nil {
                print("error get contact")
                return
            }
            
            if let snapshot = snapshotResult {
                snapshot.documents.forEach { document in
                    let dataOfContact = document.data()
                    self.listOfContact.append(Contact(dicionario: dataOfContact))
                }
                self.screen?.reloadCollectionView()
            }
        })
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.screenContact ?? false {
            return self.listOfContact.count + 1
        } else {
            return self.listOfMessages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.screenContact ?? false {
            if indexPath.row == self.listOfContact.count {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageLastCollectionViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
                cell?.setUpViewContact(contact: self.listOfContact[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        } else {
            //Celula DE CONVERSAS
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
            cell?.setUpViewConversation(conversation: self.listOfMessages[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.screenContact ?? false {
            if indexPath.row == self.listOfContact.count {
                self.alert?.addContact(completion: { value in
                    self.contact?.addContact(email: value, emailUsuarioLogado: self.emailUsuarioLogado ?? "", idUsuario: self.idUsuarioLogado ?? "")
                })
            } else {
                let vc: ChatVC = ChatVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
}

extension HomeVC: NavViewProtocol {
    
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            self.screenContact = true
            self.getContact()
            self.messagesListener?.remove()
        case .conversation:
            self.screenContact = false
            self.addListenerRecuperarConversa()
            self.screen?.reloadCollectionView()
        }
    }
    
}

extension HomeVC: ContactProtocol {
    
    func alertStateError(title: String, message: String) {
        self.alert?.getALert(title: title, message: message)
    }
    
    func succesContact() {
        self.alert?.getALert(title: "Ebaaaaaaa", message: "Usuario cadastrado com sucesso", completion: {
            self.getContact()
        })
    }
    
}
