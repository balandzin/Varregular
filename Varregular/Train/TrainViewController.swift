//
//  TrainViewController.swift
//  Varregular
//
//  Created by Антон Баландин on 13.03.24.
//

import UIKit
import SnapKit

final class TrainViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Score".localized + ": 0"
        return label
    }()
    
    private lazy var numberOfVerbLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "\(count + 1) / \(dataSource.count)"
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        
        return view
        
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simple"
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.delegate = self
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.delegate = self
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        return button
    }()
    
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    
    private var currentVerb: Verb? {
        guard count < dataSource.count else { return nil }
        return dataSource[count]
    }
    
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
        }
    }
    
    private var score = 0
    
    private var isRightAnswer = true
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select verbs".localized
        
        setupUI()
        
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Private Methods
    @objc
    private func checkAction() {
        if checkAnswers() {
            if isRightAnswer {
                score += 1
            }
            
            checkButton.backgroundColor = .systemGray5
            checkButton.setTitle("Check", for: .normal)
            
            scoreLabel.text = "Score".localized + ": \(score)"
            numberOfVerbLabel.text = "\(count + 1) / \(dataSource.count)"
            
            if count != dataSource.count - 1 {
                count += 1
            }
            
            if currentVerb?.infinitive != dataSource.last?.infinitive {
                showAlert(title: "Correct".localized, message: "Score".localized + ": \(score)")
            } else {
                showAlert(title: "Congratulations!".localized) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
             isRightAnswer = true
        } else {
                checkButton.backgroundColor = .red
                checkButton.setTitle("try again", for: .normal)
            
            isRightAnswer = false
            }
    }
    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased() == currentVerb?.participle.lowercased()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([
            scoreLabel,
            numberOfVerbLabel,
            infinitiveLabel,
            pastSimpleLabel,
            pastSimpleTextField,
            participleLabel,
            participleTextField,
            checkButton
        ])
        
        setupConstraints()
    }
    
    private func showAlert(title: String, message: String? = nil, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        }
        
        return true
    }
}

// MARK: - Keyboard events
private extension TrainViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(recognizer)    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
}

// MARK: - Setup Constraints
extension TrainViewController {
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        numberOfVerbLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.centerX.equalToSuperview()
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(participleLabel.snp.bottom).offset(10)
        }
        
        checkButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(participleTextField.snp.bottom).offset(100)
        }
    }
}
