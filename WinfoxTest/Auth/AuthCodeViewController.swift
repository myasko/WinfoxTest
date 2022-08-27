//
//  AuthCodeViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import UIKit
import FirebaseAuth

class AuthCodeViewController: UIViewController {
    
    var verifycationID: String!
    var phoneNumber: String!
    
    let codeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Введите код из смс"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var timerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let codeTextField : UITextField = {
        let txtFld = UITextField()
        txtFld.placeholder = "123456"
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        txtFld.backgroundColor = .white
        txtFld.textColor = .black
        txtFld.layer.cornerRadius = 5
        txtFld.textAlignment = .center
        txtFld.keyboardType = .numberPad
        return txtFld
    }()
    
    let getCodeAgainButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Не получили код? Отправить повторно", for: .normal)
        btn.setTitleColor(.gray , for: .normal)
        btn.backgroundColor = .clear
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Продолжить", for: .normal)
        btn.setTitleColor(.white , for: .normal)
        btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    var count = 120
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        codeTextField.delegate = self
        doneButton.addTarget(self, action: #selector(checkCode), for: .touchUpInside)
        getCodeAgainButton.addTarget(self, action: #selector(getCodeAgain), for: .touchUpInside)
        doneButton.alpha = 0.5
        doneButton.isEnabled = false
        getCodeAgainButton.alpha = 0.5
        getCodeAgainButton.isEnabled = false
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        setUpUI()
    }
    
    func setUpUI() {
        let heigth = self.view.frame.height
        let width = self.view.frame.width
        
        view.addSubview(codeLabel)
        view.addSubview(codeTextField)
        view.addSubview(doneButton)
        view.addSubview(getCodeAgainButton)
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            
            codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(heigth / 4)),
            
            codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeTextField.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 10),
            codeTextField.widthAnchor.constraint(equalToConstant: width / 3),
            codeTextField.heightAnchor.constraint(equalToConstant: 35),
            
            getCodeAgainButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 10),
            getCodeAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: getCodeAgainButton.bottomAnchor, constant: 5),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            doneButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: width / 3),
            ])
        
    }
}
extension AuthCodeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var check: Bool = false
        
        if textField.text?.count == 6 {
            check = true
        } else {
            check = false
        }
        
        if check {
            doneButton.alpha = 1
            doneButton.isEnabled = true
        } else {
            doneButton.alpha = 0.5
            doneButton.isEnabled = false
        }
    }
}

extension AuthCodeViewController {
    @objc func checkCode(sender: UIButton!) {
        guard let code = codeTextField.text else { return}
        let credetional = PhoneAuthProvider.provider().credential(withVerificationID: verifycationID, verificationCode: code)
        
        Auth.auth().signIn(with: credetional) { _, error in
            if error != nil {
                let ac = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                ac.addAction(cancel)
                self.present(ac, animated: true)
            } else {
                let placesVC = PlacesViewController()
                self.navigationController?.pushViewController(placesVC, animated: true)
            }
        }
        
        print("done button")
    }
    
    @objc func getCodeAgain(sender: UIButton!) {
        count = 120
        timerLabel.isHidden = false
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [self] verifycationID, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
        }
        print("get code again")
    }
}

extension AuthCodeViewController {

    @objc func update() {
        if count > 0 {
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            timerLabel.text =  minutes + ":" + seconds
            count -= 1
        } else {
            getCodeAgainButton.alpha = 1
            getCodeAgainButton.isEnabled = true
            timerLabel.isHidden = true
        }
    }
}
