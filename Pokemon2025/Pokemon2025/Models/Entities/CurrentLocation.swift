//
//  CurrentLocation.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/11/22.
//

import CoreLocation

/// A model representing the user's current location, including coordinates and city name.
struct CurrentLocation: PKMNModel {
  /// The geographical coordinates (latitude and longitude) of the user's current location.
  let coordinates: CLLocationCoordinate2D
  /// The name of the city corresponding to the user's current location.
  let cityName: String
}
