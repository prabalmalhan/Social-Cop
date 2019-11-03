//
//  LoginViewController.swift
//  Social Cop
//
//  Created by prabal malhan on 10/06/17.
//  Copyright © 2017 prabal malhan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    private var welcomeLabel:UILabel!
    private var questionLabel:UILabel!
    private var userButton:UIButton!
    private var departmentButton:UIButton!
    
    private var welcomeView:UIView!
    
    var typeOfUser:String!
    
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
        
        welcomeView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        welcomeLabel.frame = CGRect(x: sidePadding, y: 3*sidePadding, width: screenWidth-2*sidePadding, height: sidePadding)
        
        questionLabel.frame = CGRect(x: sidePadding, y: screenHeight/2 - 5*sidePadding, width: screenWidth-2*sidePadding, height: sidePadding)
        

        
        userButton.frame = CGRect(x: screenWidth/2-5*sidePadding/2, y: Int(questionLabel.frame.maxY)+2*sidePadding, width: 5*sidePadding, height: 4*sidePadding/3)
        
        departmentButton.frame = CGRect(x: screenWidth/2-5*sidePadding/2, y: Int(userButton.frame.maxY) + sidePadding/2, width: 5*sidePadding, height: 4*sidePadding/3)
        
    }
    
    func setup(){
        
        
        typeOfUser = userType.user.rawValue
        welcomeView = UIView()
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to Social Cop"
        welcomeLabel.textColor = CommonFunctions.hexStringToUIColor(hex: green1)
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont.systemFont(ofSize: 14)
        //        self.view.addSubview(welcomeLabel)
        
        questionLabel = UILabel()
        questionLabel.text = "Who are you?"
        questionLabel.textColor = CommonFunctions.hexStringToUIColor(hex: green1)
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        self.welcomeView.addSubview(questionLabel)
        
        departmentButton = UIButton()
        departmentButton.setTitle("Police Department", for: .normal)
        departmentButton.layer.cornerRadius = cornerRadius
        departmentButton.clipsToBounds = true
        departmentButton.backgroundColor = CommonFunctions.hexStringToUIColor(hex: teal)
        departmentButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        departmentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        departmentButton.setTitleColor(.white, for: .normal)
        self.welcomeView.addSubview(departmentButton)
        
        userButton = UIButton()
        userButton.setTitle("Public User", for: .normal)
        userButton.layer.cornerRadius = cornerRadius
        userButton.clipsToBounds = true
        userButton.backgroundColor = CommonFunctions.hexStringToUIColor(hex: teal)
        userButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        userButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        userButton.setTitleColor(.white, for: .normal)
        self.welcomeView.addSubview(userButton)
    
        
        self.view.addSubview(welcomeView)
        
    }
    @objc func buttonAction(sender:UIButton){
        if sender.titleLabel?.text == "Public User"{
            performSegue(withIdentifier: userScreen, sender: self)
            return
        }
        performSegue(withIdentifier: loginScreen, sender: self)

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
