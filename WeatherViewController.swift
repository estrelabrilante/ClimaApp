//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
   
    var weatherManager = WeatherManager();
    //hold data of current GPSlocation of phone.
    let locationManager = CLLocationManager();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self;
        // location is private data so request to user
        locationManager.requestWhenInUseAuthorization();
        //one-time delivery of users current location
        locationManager.requestLocation();
       //textfield will report to self which is weather viewController
        searchTextField.delegate = self
        //set class as delegtae
        weatherManager.delegate = self;
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation();
    }
}
//MARK: - //how to hold location once location manager found location of the user --- didUpdateLocation methods

//GPS location bsed update UI
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //last location in the array
        if let location = locations.last{
            locationManager.stopUpdatingLocation();
            let lat = location.coordinate.latitude;
            let lon = location.coordinate.longitude;
            print(lat);
            print(lon);
            weatherManager.fetchWeather(latitu: lat, longtitu: lon);
            print("got location");
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
    
    //MARK: - UITextField Delegate
    
    extension WeatherViewController: UITextFieldDelegate {
        
        @IBAction func searchPressed(_ sender: UIButton) {
           
            print(searchTextField.text!)
            
            //dismiss keyboard
            searchTextField.endEditing(true)
            
        }        //when the user click GO key in soft keyboard
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
}
    
  //MARK: - WeatherManagerDelegate method
extension WeatherViewController: WeatherManagerDelegate{
    
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
    


