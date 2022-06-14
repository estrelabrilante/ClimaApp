//
//  WeatherData.swift
//  Clima
//
//  Created by user215496 on 6/14/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
//data come from API
struct WeatherData : Decodable{
    let name : String
    let main :  Main
    let weather : [Weather]
    
}
struct Main : Decodable {
let temp: Double
}
struct Weather:Decodable{
    let description: String
    let id : Int
}
