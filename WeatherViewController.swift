//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       //textfield will report to self which is weather viewController
        searchTextField.delegate = self
        //set class as delegtae
        weatherManager.delegate = self;
    }

    @IBAction func searchPressed(_ sender: UIButton) {
       
        print(searchTextField.text!)
        
        //dismiss keyboard
        searchTextField.endEditing(true)
        
    }
    //when the user click GO key in soft keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        print(searchTextField.text!)
        //dismiss keyboard
        searchTextField.endEditing(true)
        return true
    }
  //clear textField after end editing is true.
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use searchTextField.text to get the weather for that city.
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        //resetting
        searchTextField.text = ""
    }
    //identity of object caused delegate method: TextField
    //validation on user typed
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //any textField could triggered
        if textField.text != ""{
            return true
        }
        else{
            textField.placeholder = "Type something here"
            return false
        }
}
    //implementation of delegate-protocol method
    /*
     func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
    }
*/
    //delegate method naming convention: identity of object caused delegate method: Weather Manager
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //Display using DispatchQueue main async
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString;
            self.conditionImageView.image = UIImage(systemName: weather.conditionName);
            self.cityLabel.text = weather.cityName;
            
        }
        
        //print(weather.temperature)
    }
    func didFailWithError(error: Error) {
        print(error)
    }

}
