//
//  MessageAllModel.swift
//  MessageAppViewCodeCourse
//
//  Created by Jean Lucas Vitor on 13/04/22.
//

import Foundation

class Message {
    
    var texto: String?
    var idUsuario: String?
    
    init(dicionario: [String: Any]) {
        self.texto = dicionario["texto"] as? String
        self.idUsuario = dicionario["idUsuario"] as? String
    }
}

class Conversation {
    
    var nome: String?
    var ultimaMensagem: String?
    var idDestinatario: String?
    
    init(dicionario: [String: Any]) {
        self.nome = dicionario["nomeUsuario"] as? String
        self.ultimaMensagem = dicionario["ultimaMensagem"] as? String
        self.idDestinatario = dicionario["idDestinatario"] as? String
    }
}

class User {
    
    var nome: String?
    var email: String?
    
    init(dicionario: [String: Any]) {
        self.nome = dicionario["nome"] as? String
        self.email = dicionario["email"] as? String
    }
}


class Contact {
    
    var nome: String?
    var id: String?
    
    init(dicionario: [String: Any]?) {
        self.nome = dicionario?["nome"] as? String
        self.id = dicionario?["id"] as? String
    }
    
    convenience init(nome: String?, id: String?) {
        self.init(dicionario: nil)
        self.nome = nome
        self.id = id
    }
}
