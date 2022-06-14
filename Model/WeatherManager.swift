//
//  WeatherManager.swift
//  Clima
//
//  Created by user215496 on 6/10/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
//protocol and delegate method
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather:  WeatherModel)
}

struct WeatherManager{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=692d5c0caa06a72f35debdc0b98b39f3&units=metric";
    //set delegate as optional weathermanagerdelegate
    var delegate: WeatherManagerDelegate?
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    
        self.performRequest(urlString: urlString);
    
    }
    //Networking
   
    func performRequest(urlString: String){
        //create a URL
        if let url = URL(string: urlString){
            //create a URLsession
            let session = URLSession(configuration: .default);
            //give session a task
            let task = session.dataTask(with: url) { (data,response,error) in
                if error != nil{
                    print(error!)
                    return
                };
                if let safeData = data{
                    let dataString = String(data: safeData, encoding: .utf8)
                   print(dataString!)
                    //weather object as output
                    if let weatherObject = self.parseJson(weatherData: safeData){
                        //delegate
                        self.delegate?.didUpdateWeather(weather: weatherObject)
                        
                    }
                }
                
            }
            //start the task
            task.resume();
        }
        
    }
    //parse JSON format into swift object
    func parseJson(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder();
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData);
            let name = decodedData.name;
            let temp = decodedData.main.temp
            print(decodedData.weather[0].description)
            let id = decodedData.weather[0].id
           let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            //calling computed property from weather model
            print(weather.conditionName)
            print(weather.temperatureString);
            //calling function from weather model
            // print( weather.getConditionName(weatherId: id))
            
            return weather
           
        }
        catch{
            print(error)
            return nil
        }
    }
   
   
}
