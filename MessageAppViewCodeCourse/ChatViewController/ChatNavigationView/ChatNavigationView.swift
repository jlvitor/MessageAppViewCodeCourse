//
//  ChatNavigationView.swift
//  MessageAppViewCodeCourse
//
//  Created by Jean Lucas Vitor on 13/04/22.
//

import UIKit

class ChatNavigationView: UIView {
    
    var controller: ChatVC? {
        didSet {
            self.backButton.addTarget(controller, action: #selector(ChatVC.tappedBackButton), for: .touchUpInside)
        }
    }
    
    lazy var navBackGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Procurar"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    lazy var customImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 26
        img.image = UIImage(named: "imagem-perfil")
        return img
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        self.addSubview(self.navBackGroundView)
        self.navBackGroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.backButton)
        self.navBar.addSubview(self.customImage)
        self.navBar.addSubview(self.searchBar)
        self.searchBar.addSubview(self.searchLabel)
        self.searchBar.addSubview(self.searchButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.navBackGroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackGroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackGroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackGroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.backButton.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 20),
            self.backButton.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.backButton.heightAnchor.constraint(equalToConstant: 30),
            self.backButton.widthAnchor.constraint(equalToConstant: 30),
            
            self.customImage.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 20),
            self.customImage.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.customImage.heightAnchor.constraint(equalToConstant: 55),
            self.customImage.widthAnchor.constraint(equalToConstant: 55),
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.customImage.trailingAnchor, constant: 20),
            self.searchBar.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -20),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchButton.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.searchButton.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchButton.widthAnchor.constraint(equalToConstant: 20),
            self.searchButton.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
}
