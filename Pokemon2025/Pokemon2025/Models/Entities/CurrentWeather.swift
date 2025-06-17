//
//  CurrentWeather.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 25/11/22.
//

import WeatherKit

/// A model representing the current weather for a specific city.
struct CurrentWeather: PKMNModel {
  /// The current temperature in degrees Celsius.
  let temperature: Double
  /// A textual description of the current weather condition (e.g., "Sunny").
  let condition: String
  /// The symbol name representing the current weather condition (for system images).
  let symbolName: String
  /// The name of the city for which the weather data applies.
  let cityName: String

  // MARK: - Init

  /// Creates a new `CurrentWeather` instance with the specified properties.
  /// - Parameters:
  ///   - temperature: The current temperature in degrees Celsius.
  ///   - condition: A textual description of the current weather condition.
  ///   - symbolName: The symbol name representing the current weather condition.
  ///   - cityName: The name of the city for which the weather is described.
  init(temperature: Double, condition: String, symbolName: String, cityName: String) {
    self.temperature = temperature
    self.condition = condition
    self.symbolName = symbolName
    self.cityName = cityName
  }

  /// Creates a new `CurrentWeather` instance from a WeatherKit `CurrentWeather` object.
  /// - Parameters:
  ///   - weather: The WeatherKit `CurrentWeather` object.
  ///   - cityName: The name of the city for which the weather is described.
  @available(iOS 16.0, *)
  init(weather: WeatherKit.CurrentWeather, cityName: String) {
    self.temperature = weather.temperature.value
    self.condition = weather.condition.description
    self.symbolName = weather.symbolName
    self.cityName = cityName
  }
}
