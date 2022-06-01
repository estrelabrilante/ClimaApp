//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
// learned by Shynu Mary Varghese
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //textField should report back to delegate (which is current viewcontroller)
        searchTextField.delegate = self;
    }
    // when user click on Return Key , textField should report to delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //disappear keyboard when user Click Return
        searchTextField.endEditing(true)
        //print result in console
        print(searchTextField.text!);
        return true;
    }
    //user end editing that get notified to delegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use location entered in textField before resetting textField thereby checking weather data
        
        //clear or reset search textField while clicking return key / search icon
        searchTextField.text = ""
    }
//when user press search button
    @IBAction func searchPressed(_ sender: UIButton) {
        //disappear keyboard when user Click search button
        searchTextField.endEditing(true);
        print(searchTextField.text!)
    }
    // userful for validation in a textField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.text != ""){
            return true
        }
        else{
            textField.placeholder = "Type something to search"
            return false
        }
        
    }
    
}

