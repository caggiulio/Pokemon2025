//
//  CurrentLocation.swift
//  PokemonTest
//
//  Created by Nunzio Giulio Caggegi on 26/11/22.
//

import CoreLocation

struct CurrentLocation: PKMNModel {
  let coordinates: CLLocationCoordinate2D
  let cityName: String
}

