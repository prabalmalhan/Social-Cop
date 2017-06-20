//
//  SignupViewController.swift
//  Social Cop
//
//  Created by prabal malhan on 11/06/17.
//  Copyright © 2017 prabal malhan. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    private var emailField:UITextField!
    private var passField:UITextField!
    private var submitButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        emailField.frame = CGRect(x: sidePadding, y: 3*sidePadding, width: screenWidth - 2*sidePadding, height: 4*sidePadding/3)
        passField.frame = CGRect(x: sidePadding, y: Int(emailField.frame.maxY)+sidePadding/2, width: screenWidth - 2*sidePadding, height: 4*sidePadding/3)
        submitButton.frame = CGRect(x: sidePadding, y: Int(passField.frame.maxY)+sidePadding/2, width: screenWidth - 2*sidePadding, height: 4*sidePadding/3)
    }
    func setup(){
        emailField = UITextField()
        emailField.placeholder = "Email"
        emailField.layer.cornerRadius = cornerRadius
        emailField.clipsToBounds = true
        emailField.borderStyle = .bezel
        emailField.layer.borderWidth = 2
        emailField.layer.borderColor = UIColor.gray.cgColor
        emailField.autocorrectionType = .no
        self.view.addSubview(emailField)
        
        passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.cornerRadius = cornerRadius
        passField.clipsToBounds = true
        passField.borderStyle = .bezel
        passField.layer.borderWidth = 2
        passField.layer.borderColor = UIColor.gray.cgColor
        passField.autocorrectionType = .no
        self.view.addSubview(passField)
        
        submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = cornerRadius
        submitButton.clipsToBounds = true
        submitButton.backgroundColor = CommonFunctions.hexStringToUIColor(hex: teal)
        submitButton.addTarget(self, action: #selector(submit(sender:)), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        submitButton.setTitleColor(.white, for: .normal)
        
        self.view.addSubview(submitButton)
    }
    func submit(sender:UIButton){
        self.view.endEditing(true)
        let alert = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        if emailField.text == "" || passField.text == ""{
            present(alert, animated: true, completion: nil)
            return
        }
        if !(CommonFunctions.isValidEmail(testStr: emailField.text ?? "")) {
            alert.message = "Please enter a valid email"
            present(alert, animated: true, completion: nil)
            return
        }
        if emailField.text == "admin@admin.com" && passField.text == "admin"{
            performSegue(withIdentifier: complaintsScreen, sender: self)
        }
        else{
            alert.message = "Incorrect Email or Password"
            present(alert, animated: true, completion: nil)
            return
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
