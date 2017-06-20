//
//  Constants.swift
//  FlexipleDemo
//
//  Created by prabal malhan on 25/05/17.
//  Copyright © 2017 prabal malhan. All rights reserved.
//

import Foundation
import UIKit

enum userType:String{
    case user = "user"
    case department = ""
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate


let sidePadding = 30
let cornerRadius:CGFloat = 5.0
var screenHeight = Int(UIScreen.main.bounds.height)
var screenWidth = Int(UIScreen.main.bounds.width)


//MARK: Color
let green1 = "38af4b"
let teal = "29BB9C"
let sectionGray = "d8d8d8"

//Mark:Cell Identifier
let projectCell = "projectCell"

//MARK: SegueIdentifiers
let loginScreen = "loginScreen"
let userScreen = "userScreen"
let complaintsScreen = "showComplaints"

//MARK: Notfications
let backToWelcomeScreen = Notification.Name("backToWelcomeScreen")
