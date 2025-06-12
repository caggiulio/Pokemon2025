//
//  Forms.swift
//  PokemonTest
//
//  Created on 24/01/22.
//

import Foundation

struct Forms: PKMNModel {
  let name: String

  init(formsDataSource: FormsDataSource) {
    name = formsDataSource.name
  }
}
