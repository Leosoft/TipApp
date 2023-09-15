import SwiftUI

struct WelcomeView: View {
    @State private var isAppStarted = false // Para controlar si la aplicación se ha iniciado
    
    var body: some View {
        NavigationView {
            ZStack {
                // Agregar el fondo degradado aquí
                LinearGradient(
                    gradient: Gradient(stops: [
                        Gradient.Stop(color: Color.blue, location: 0.00), // Color azul
                                Gradient.Stop(color: Color.blue, location: 1.00)  // Color azul
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("CALCULATE TIPS")
                        .font(.custom("Silkscreen", size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        // Acción a realizar al presionar el botón para iniciar la aplicación
                        isAppStarted = true
                    }) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
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



