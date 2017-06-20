//
//  CompaintsTableViewCell.swift
//  Social Cop
//
//  Created by prabal malhan on 12/06/17.
//  Copyright © 2017 prabal malhan. All rights reserved.
//

import UIKit
import PureLayout
import GoogleMaps
class CompaintsTableViewCell: UITableViewCell {

    var locationLabel:UILabel!
    var imageOfOffender:UIImageView!
//    var takeAction:UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(){
        imageOfOffender = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 300))
        imageOfOffender.contentMode = .scaleAspectFit
        imageOfOffender.clipsToBounds = true
        self.addSubview(imageOfOffender)
        
        locationLabel = UILabel(frame: CGRect(x: 0, y: 300-sidePadding, width: screenWidth, height: sidePadding))
        locationLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        locationLabel.textColor = .white
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        locationLabel.textAlignment = .center
        self.addSubview(locationLabel)
//        
//        imageOfOffender.autoPinEdge(toSuperviewEdge: .leading)
//        imageOfOffender.autoPinEdge(toSuperviewEdge: .trailing)
//        imageOfOffender.autoPinEdge(toSuperviewEdge: .top)
//        imageOfOffender.autoPinEdge(.bottom, to: .top, of: locationLabel, withOffset: CGFloat(-sidePadding/6))
//        
//        locationLabel.autoPinEdge(toSuperviewEdge: .leading, withInset:CGFloat(sidePadding))
//        locationLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset:CGFloat(sidePadding))
//        locationLabel.autoPinEdge(toSuperviewEdge: .bottom)
        
//        takeAction = UIButton()
        
        
    }
    
    func updateData(dict:Dictionary<String, Any>){

        if let loc = dict["loc"] as? String{
            locationLabel.text = loc
            if let lat = dict["lat"] as? String,let long = dict["long"] as? String{
                let latSub = lat.substring(to: lat.index(lat.startIndex, offsetBy: 4))
                let longSub = long.substring(to: long.index(long.startIndex, offsetBy: 4))
                locationLabel.text = loc + "  Location-> Lat: \(latSub), Long: \(longSub)"
            }
        }
        if let imgData = dict["imgData"] as? Data{
            let img = UIImage(data: imgData)!

            imageOfOffender.image = img.fixOrientation()
//            if let img = CommonFunctions.loadImageFromPath(path: imgData){                
//                imageOfOffender.image = img
//                
//            }
        }
    }

}
extension UIImage {
    
    func fixOrientation() -> UIImage {
        
        // No-op if the orientation is already correct
        if ( self.imageOrientation == UIImageOrientation.up ) {
            return self;
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if ( self.imageOrientation == UIImageOrientation.down || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImageOrientation.left || self.imageOrientation == UIImageOrientation.leftMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }
        
        if ( self.imageOrientation == UIImageOrientation.right || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0));
        }
        
        if ( self.imageOrientation == UIImageOrientation.upMirrored || self.imageOrientation == UIImageOrientation.downMirrored ) {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if ( self.imageOrientation == UIImageOrientation.leftMirrored || self.imageOrientation == UIImageOrientation.rightMirrored ) {
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;
        
        ctx.concatenate(transform)
        
        if ( self.imageOrientation == UIImageOrientation.left ||
            self.imageOrientation == UIImageOrientation.leftMirrored ||
            self.imageOrientation == UIImageOrientation.right ||
            self.imageOrientation == UIImageOrientation.rightMirrored ) {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        } else {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context and return it
        return UIImage(cgImage: ctx.makeImage()!)
    }
}
