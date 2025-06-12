//
//  SplashModel.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import Foundation
import SwiftUI

/// The local model for the splash screen.
struct SplashModel: CustomModel {
  /// The `ImageResource` to show.
  let resource: ImageResource

  /// The size of the image to show.
  let imageSize: CGSize
}
