//
//  ViewController.swift
//  Varregular
//
//  Created by Антон Баландин on 12.03.24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Verregular".uppercased()
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select verbs".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = cornerRadius
        
        button.addTarget(self, action: #selector(goToSelectViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Train verbs".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = cornerRadius
        
        button.addTarget(self, action: #selector(goToTrainViewController), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private let cornerRadius: CGFloat = 20
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    // MARK: - Private Methods
    @objc private func goToSelectViewController() {
        navigationController?.pushViewController(SelectVerbsViewController(), animated: true)
    }
    
    @objc private func goToTrainViewController() {
        navigationController?.pushViewController(TrainViewController(), animated: true)
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        
        view.addVerticalGradientLayer()

        configureConstraints()
    }
    
    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            firstButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            firstButton.heightAnchor.constraint(equalToConstant: 80),
            
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 40),
            secondButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            secondButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}


