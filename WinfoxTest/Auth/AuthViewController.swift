//
//  ViewController.swift
//  WinfoxTest
//
//  Created by Георгий Бутров on 27.08.2022.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    let phoneNumberTextField : UITextField = {
        let txtFld = UITextField()
        txtFld.placeholder = "+7(xxx)-xxx-xx-xx"
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        txtFld.backgroundColor = .white
        txtFld.textColor = .black
        txtFld.layer.cornerRadius = 5
        txtFld.textAlignment = .center
        txtFld.keyboardType = .numberPad
        return txtFld
    }()
    
    let phoneNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Введите номер телефона"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let getCodeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Получить код", for: .normal)
        btn.setTitleColor(.white , for: .normal)
        btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        
        btn.layer.cornerRadius = 10
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 0.7)
        phoneNumberTextField.delegate = self
        getCodeButton.addTarget(self, action: #selector(getCode), for: .touchUpInside)
        getCodeButton.alpha = 0.5
        getCodeButton.isEnabled = false
        setUpUI()
       
    }

    func setUpUI() {
        let heigth = self.view.frame.height
        let width = self.view.frame.width
        
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(getCodeButton)
//
//
        NSLayoutConstraint.activate([
            phoneNumberLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(heigth / 4)),
            phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 5),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: width / 2),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 35),
            
            
            getCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getCodeButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 10),
            getCodeButton.widthAnchor.constraint(equalToConstant: width / 3)
        ])
    }
    
    
}

extension AuthViewController: UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let formatter = TextFormatter()
        let fullString = (textField.text ?? "") + string
        textField.text = formatter.format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var check: Bool = false
        let formatter = TextFormatter()
        check = formatter.isNumberValid(number: textField.text!)
        
        if check {
            getCodeButton.alpha = 1
            getCodeButton.isEnabled = true
        } else {
            getCodeButton.alpha = 0.5
            getCodeButton.isEnabled = false
        }
    }
}
extension AuthViewController {
    @objc func getCode(sender: UIButton!) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text!, uiDelegate: nil) { verifycationID, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                let authCodeVC = AuthCodeViewController()
                authCodeVC.verifycationID = verifycationID
                authCodeVC.phoneNumber = self.phoneNumberTextField.text!
                self.navigationController?.pushViewController(authCodeVC, animated: true)
            }
        }
        
        print("get code button")
    }
}
