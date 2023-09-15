import SwiftUI

struct TipCalculatorView: View {
    @EnvironmentObject var presenter: TipCalculatorPresenter
    @State private var isAmountValid = true // Para validar el monto ingresado
    @State private var isAppClosed = false // Para controlar si la aplicación se cierra
    
    var totalAmount: Double {
        presenter.model.billAmount
    }
    
    var tipAmount: Double {
        totalAmount * presenter.model.tipPercentage
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Monto de la cuenta")) {
                    HStack {
                        Text("$")
                            .foregroundColor(.primary)
                        TextField("Monto", value: $presenter.model.billAmount, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Porcentaje de propina")) {
                    Picker("Porcentaje", selection: $presenter.model.tipPercentage) {
                        Text("10%").tag(0.10)
                        Text("15%").tag(0.15)
                        Text("20%").tag(0.20)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Cantidad de personas")) {
                    Stepper(value: $presenter.model.numberOfPeople, in: 1...10) {
                        Text("\(presenter.model.numberOfPeople)")
                    }
                }
                
                Section(header: Text("Total de propina")) {
                    Text("$\(tipAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Tip Calculate")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Acción para cerrar la aplicación
                        isAppClosed = true
                    }) {
                        Text("Cerrar")
                            .foregroundColor(.blue)
                    }
                    .fullScreenCover(isPresented: $isAppClosed, content: {
                        // Vista de confirmación antes de cerrar la aplicación
                        VStack {
                            ZStack{
                                Color.blue
                                    .edgesIgnoringSafeArea(.all)
                                VStack{
                                    Text("¿Desea cerrar la aplicación?")
                                        .font(.title)
                                        .padding()
                                        .foregroundColor(.primary)
                                    HStack {
                                        Button(action: {
                                            // Cierra la aplicación
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            exit(0)
                                        }) {
                                            Text("Aceptar")
                                                .padding()
                                                .background(Color.white)
                                                .foregroundColor(.black)
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action: {
                                            isAppClosed = false // Cierra la vista de confirmación
                                        }) {
                                            Text("Cancelar")
                                                .padding()
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                    }
                                }
                            }
                        }
                        })
                    
                }
            }
        }
        /*
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(red: 1, green: 0.4, blue: 0.27), location: 0.00),
                    Gradient.Stop(color: Color(red: 1, green: 0.19, blue: 0.19), location: 1.00)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )*/
    }
}

