//
//  Home+View.swift
//  SwiftUIArchitecture
//
//  Created by Nunzio Giulio Caggegi on 11/06/23.
//

import SwiftUI

extension UI.Funnel.Home {
  struct View: SwiftUI.View {
    
    // MARK: - Stored Properties
    
    /// The `UI.Funnel.Home.ViewModel` of the view.
    @StateObject var viewModel = UI.Funnel.Home.ViewModel()
    
    // MARK: - View
    
    var body: some SwiftUI.View {
      VStack {
        AsyncImage(url: viewModel.imageURL) { phase in
          switch phase {
            case .success(let image):
              image
                .resizable()
                .frame(width: 185, height: 185)
              
            default:
              Image("logo")
          }
        }
        
        Text(viewModel.name)
          .font(.title2)
          .fontWeight(.black)
        
        Button("Random", action: viewModel.didTapRandomButton)
          .padding(.top, 150)
          .buttonStyle(.borderedProminent)
      }
      .loader(isShowing: viewModel.localState.isLoading)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .edgesIgnoringSafeArea(.all)
      .navigationBarHidden(true)
    }
  }
}
