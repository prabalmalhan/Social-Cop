//
//  UserActionsViewController.swift
//  Social Cop
//
//  Created by prabal malhan on 11/06/17.
//  Copyright © 2017 prabal malhan. All rights reserved.
//

import UIKit
import GoogleMaps

class UserActionsViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLLocationManagerDelegate  {
    var signalNotWorkingButton:UIButton!
    var illegalParkingButton:UIButton!
    var imagePicker: UIImagePickerController!
    var selectedImageView:UIImageView!
    var locationTextField: UITextField!
    var submitButton:UIButton!
    var image:UIImage!
    var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var locValue = CLLocationCoordinate2D()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setup()
        
    }
    override func viewWillLayoutSubviews() {
        signalNotWorkingButton.frame = CGRect(x: 0, y: 6*sidePadding/2, width: screenWidth/2, height: 4*sidePadding/3)
        illegalParkingButton.frame = CGRect(x: screenWidth/2, y: 6*sidePadding/2, width: screenWidth/2, height: 4*sidePadding/3)
        locationTextField.frame = CGRect(x: sidePadding/2, y: Int(illegalParkingButton.frame.maxY)+sidePadding, width: screenWidth - sidePadding, height: sidePadding)
        selectedImageView.frame = CGRect(x: 0, y: Int(locationTextField.frame.maxY)+sidePadding, width: screenWidth/2, height: 5*sidePadding)
        mapView.frame = CGRect(x: screenWidth/2, y: Int(locationTextField.frame.maxY)+sidePadding, width: screenWidth/2, height: 5*sidePadding)

        submitButton.frame = CGRect(x: 0 , y: Int(selectedImageView.frame.maxY)+sidePadding, width: screenWidth, height: 4*sidePadding/3)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates:CLLocationCoordinate2D = manager.location!.coordinate
        locValue = coordinates
        mapView.moveCamera(GMSCameraUpdate.setTarget(locValue, zoom: 16))

    }
    func setup(){
        signalNotWorkingButton = UIButton()
        signalNotWorkingButton.setTitle("Traffic Light", for: .normal)
        signalNotWorkingButton.layer.cornerRadius = cornerRadius
        signalNotWorkingButton.clipsToBounds = true
        signalNotWorkingButton.backgroundColor = CommonFunctions.hexStringToUIColor(hex: teal)
        signalNotWorkingButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        signalNotWorkingButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        signalNotWorkingButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(signalNotWorkingButton)
        
        illegalParkingButton = UIButton()
        illegalParkingButton.setTitle("Illegal Parking", for: .normal)
        illegalParkingButton.layer.cornerRadius = cornerRadius
        illegalParkingButton.clipsToBounds = true
        illegalParkingButton.backgroundColor = CommonFunctions.hexStringToUIColor(hex: teal)
        illegalParkingButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        illegalParkingButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        illegalParkingButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(illegalParkingButton)
        
        selectedImageView = UIImageView()
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.clipsToBounds = true
        selectedImageView.backgroundColor = .white
        
        self.view.addSubview(selectedImageView)
        
        locationTextField = UITextField()
        locationTextField.placeholder = "Enter Problem or different issue"
        locationTextField.layer.cornerRadius = cornerRadius
        locationTextField.clipsToBounds = true
        locationTextField.borderStyle = .bezel
        locationTextField.layer.borderWidth = 2
        locationTextField.layer.borderColor = UIColor.gray.cgColor
        locationTextField.autocorrectionType = .no
        self.view.addSubview(locationTextField)
        
        submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = cornerRadius
        submitButton.clipsToBounds = true
        submitButton.backgroundColor = CommonFunctions.hexStringToUIColor(hex: teal)
        submitButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        submitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        submitButton.setTitleColor(.white, for: .normal)
        
        let coordinates = self.locValue
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 6.0)
        
        let view = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView = view

        self.view.addSubview(mapView)
        
        self.view.addSubview(submitButton)
    }
    func buttonAction(sender:UIButton){
        if sender.titleLabel?.text == "Submit"{
            if selectedImageView.image != nil && !(locationTextField.text?.isEmpty)!{
                let visualView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
                visualView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                visualView.alpha = 0
                let label = UILabel(frame: CGRect(x: 0, y: screenHeight/2-sidePadding/2, width: screenWidth, height: sidePadding))
                label.text = "Posting"
                label.textAlignment = .center
                label.textColor = .white
                
                
                appDelegate.window?.addSubview(visualView)
                appDelegate.window?.addSubview(label)
                UIView.animate(withDuration: 0.5, animations: {
                    visualView.alpha = 1
                }, completion: { (comp) in
                    label.removeFromSuperview()
                    visualView.removeFromSuperview()
                })
                CommonFunctions.saveInDefaults(image: selectedImageView.image!, loc: locationTextField.text!, lat: locValue.latitude.description,long: locValue.longitude.description )
                let alert = UIAlertController(title: "Posted Successfully", message: "Your complaint has been registered", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                selectedImageView.image = nil
                locationTextField.text = nil
                return
            }
            else{
                self.view.endEditing(true)
                let alert = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                if locationTextField.text == "" {
                    present(alert, animated: true, completion: nil)
                    return
                }
            }
        }
        takePhoto(sender)
    }
    //MARK: - Take image
    func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    

    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        image = newImage
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.image = newImage
        update()

        dismiss(animated: true, completion: nil)

        
    }
    func update(){
        mapView.moveCamera(GMSCameraUpdate.setTarget(locValue, zoom: 16))
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.title = "Current Location"
        //        marker.snippet = "Australia"
        marker.map = self.mapView
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        return
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
