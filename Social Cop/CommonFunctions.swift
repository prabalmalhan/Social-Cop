//
//  CommonFunctions.swift
//  CM
//
//  Created by Prabal on 15/07/17.
//  Copyright © 2017 Prabal. All rights reserved.
//

import Foundation
import UIKit
//import Alamofire
import CoreData
import GoogleMaps
class CommonFunctions {
    
    class  func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func calculateHeight(inString:String,forFont font:UIFont,andWidthOfLabel width:CGFloat) -> CGFloat
    {
        let paragraphStyle = NSMutableParagraphStyle()
        
        let messageString = inString
        let attributes : [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : font,
                                                          NSAttributedStringKey.paragraphStyle: paragraphStyle,
                                                          NSAttributedStringKey.baselineOffset: NSNumber(value: 0)
        ]
        
        let attributedString : NSAttributedString = NSAttributedString(string: messageString, attributes: attributes)
        
        let rect : CGRect = attributedString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        let requredSize:CGRect = rect
        return requredSize.height
        
    }
    
    class func justifiedText(string:String) -> NSAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        
        let attributedString = NSAttributedString(string: string,
                                                  attributes: [
                                                    NSAttributedStringKey.paragraphStyle: paragraphStyle,
                                                    NSAttributedStringKey.baselineOffset: NSNumber(value: 0)
            ])
        return attributedString
    }
  
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    class func stringFromMilliSec(milliseconds:Double) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        
        return formatter.string(from: date)
    }
    
    class func videoIdFromYoutubeUrl(checkString:String) -> String?
    {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        let nsLink = checkString as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0,length: nsLink.length)
        let matches = regExp.matches(in: checkString as String, options:options, range:range)
        if let firstMatch = matches.first {
            print(firstMatch)
            
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }

    class func saveImageDocumentDirectory(imageName:String,image:UIImage) -> String{
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        print(paths)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        return paths
    }
    class func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    class func getImage(imageName:String)-> UIImage?{
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePAth){
            let img = UIImage(contentsOfFile: imagePAth)
            return img
        }
        return nil
    }
    class func removeImage(itemName:String?, fileExtension: String?) {
        if itemName == nil || fileExtension == nil{
            return
        }
        let name = itemName!
        let ext = fileExtension!
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(name).\(ext)"
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    class func attributedString(from string: String, nonBoldRange: NSRange?,fontSize:CGFloat) -> NSAttributedString {

        let attrs = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedStringKey.foregroundColor: UIColor.black
        ]
        let nonBoldAttribute = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
    class func saveInDefaults(image:UIImage, loc:String,lat:String, long:String){
        let pngImageData = UIImagePNGRepresentation(image)

        let dict = ["imgData":pngImageData ?? "","loc":loc,"lat":lat,"long":long] as [String : Any]
        appDelegate.savedComplaint.append(dict)
        UserDefaults.standard.set(dict, forKey: "complaints")

    }

}
//struct AppUtility {
//    
//    // This method will force you to use base on how you configure.
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
//        
//        if let delegate = UIApplication.shared.delegate as? AppDelegate {
//            delegate.orientationLock = orientation
//        }
//    }
//    
//    // This method done pretty well where we can use this for best user experience.
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
//        
//        self.lockOrientation(orientation)
//        
//        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
//    }
//    
//}
