//
//  WeatherManager.swift
//  Clima
//
//  Created by user202406 on 6/2/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=692d5c0caa06a72f35debdc0b98b39f37&units=metric";
    //fetching city name
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)";
        //print(urlString)
        performRequest(urlString:urlString);
    }
    func performRequest(urlString:String){
        //create a URL
        if let url = URL(string: urlString){
            //create a URLString session
            let session = URLSession(configuration: .default);
            //give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                else{
                    if let safeData = data{
                        let dataString = String(data: safeData, encoding: .utf8)
                        print(dataString)
                    }
                }
                }
            //start the task
            task.resume();
        }
    }
    

}
