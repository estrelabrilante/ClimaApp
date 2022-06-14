//
//  WeatherManager.swift
//  Clima
//
//  Created by user215496 on 6/10/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=692d5c0caa06a72f35debdc0b98b39f3&units=metric"
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
                   // let dataString = String(data: safeData, encoding: .utf8)
                   // print(dataString!)
                    self.parseJson(weatherData: safeData)
                }            }
            //start the task
            task.resume();
        }
        
    }
    //parse JSON format
    func parseJson(weatherData: Data){
        let decoder = JSONDecoder();
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData);
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        }
        catch{
            print(error)
        }
    }
   
}
