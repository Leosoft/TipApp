//
//  WelcomeView.swift
//  TipApp
//
//  Created by Leonardo Zabala on 13/09/2023.
//

import SwiftUI

struct WelcomeView: View {
    @State private var isAppStarted = false // Para controlar si la aplicación se ha iniciado
    
    var body: some View {
        NavigationView {
            ZStack {
                // Agregar el fondo degradado aquí
                LinearGradient(
                    gradient: Gradient(stops: [
                        Gradient.Stop(color: Color(red: 1, green: 0.4, blue: 0.27), location: 0.00),
                        Gradient.Stop(color: Color(red: 1, green: 0.19, blue: 0.19), location: 1.00)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Welcome to TipApp")
                        .font(.custom("Apple Chancery", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // Acción a realizar al presionar el botón para iniciar la aplicación
                        isAppStarted = true
                    }) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                    .padding(.top, 20) // Espacio entre el texto y el botón
                    .fullScreenCover(isPresented: $isAppStarted, content: {
                        TipCalculatorView()
                            .environmentObject(TipCalculatorPresenter())
                    })
                }
            }
        }
    }
}



