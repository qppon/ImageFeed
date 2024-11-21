//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Jojo Smith on 11/12/24.
//

import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        makeProfileIcon()
        makeLabels()
        makeButton()
    }
    
    func makeProfileIcon() {
        let profileIconImage = UIImage(resource: .userpick)
        let profileIcon = UIImageView(image: profileIconImage)
        profileIcon.layer.cornerRadius = 35
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileIcon)
        
        NSLayoutConstraint.activate([
            profileIcon.heightAnchor.constraint(equalToConstant: 70),
            profileIcon.widthAnchor.constraint(equalToConstant: 70),
            profileIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            profileIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    func makeLabels() {
        let nameLabel = UILabel()
        nameLabel.text = "Екатерина Новикова"
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        let instLabel = UILabel()
        instLabel.text = "@ekaterina_nov"
        instLabel.font = UIFont.systemFont(ofSize: 13)
        instLabel.textColor = .ypGray
        instLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instLabel)
        
        let helloWorldLabel = UILabel()
        helloWorldLabel.text = "Hello, world!"
        helloWorldLabel.font = UIFont.systemFont(ofSize: 13)
        helloWorldLabel.textColor = .white
        helloWorldLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(helloWorldLabel)
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 152),
            instLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            helloWorldLabel.topAnchor.constraint(equalTo: instLabel.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            helloWorldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            
        ])
    }
    
    func makeButton() {
        let exitButton = UIButton.systemButton(
            with: UIImage.exitButton,
            target: self,
            action: #selector(self.didTapButton)
        )
        exitButton.tintColor = .ypRed
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        exitButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 111).isActive = true
    }
    
    @objc
    private func didTapButton() {
        
    }
}
