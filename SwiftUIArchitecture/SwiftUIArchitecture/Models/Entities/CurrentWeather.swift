//
//  CurrentWeather.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import WeatherKit

struct CurrentWeather: PKMNModel {
  let temperature: Double
  let condition: String
  let symbolName: String
  let cityName: String
  
  init(temperature: Double, condition: String, symbolName: String, cityName: String) {
    self.temperature = temperature
    self.condition = condition
    self.symbolName = symbolName
    self.cityName = cityName
  }
  
  @available(iOS 16.0, *)
  init(weather: WeatherKit.CurrentWeather, cityName: String) {
    self.temperature = weather.temperature.value
    self.condition = weather.condition.description
    self.symbolName = weather.symbolName
    self.cityName = cityName
  }
}
