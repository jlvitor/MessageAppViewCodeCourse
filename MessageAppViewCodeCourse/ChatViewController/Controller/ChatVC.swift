//
//  ChatViewController.swift
//  MessageAppViewCodeCourse
//
//  Created by Jean Lucas Vitor on 13/04/22.
//

import UIKit
import Firebase

class ChatVC: UIViewController {
    
    var screen: ChatViewScreen?
    
    override func loadView() {
        self.screen = ChatViewScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }


}
