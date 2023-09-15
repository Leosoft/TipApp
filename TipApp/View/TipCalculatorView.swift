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
    
    var tipPerPerson: Double {
            let totalTip = totalAmount * presenter.model.tipPercentage
            return totalTip / Double(presenter.model.numberOfPeople)
        }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Total Amount")) {
                    HStack {
                        Text("$")
                            .foregroundColor(.primary)
                        TextField("Monto", value: $presenter.model.billAmount, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section(header: Text("Tip Percentage")) {
                    Picker("Porcentaje", selection: $presenter.model.tipPercentage) {
                        Text("10%").tag(0.10)
                        Text("15%").tag(0.15)
                        Text("20%").tag(0.20)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount of people")) {
                    Stepper(value: $presenter.model.numberOfPeople, in: 1...10) {
                        Text("\(presenter.model.numberOfPeople)")
                    }
                }
                
                Section(header: Text("Tip Amount")) {
                    Text("$\(tipAmount, specifier: "%.2f")")
                }
                Section(header: Text("Tip Per Person")) {
                                    Text("$\(tipPerPerson, specifier: "%.2f") per person")
                                        .foregroundColor(.blue)
                                }
            }
            .navigationBarTitle("Calculate Tips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Acción para cerrar la aplicación
                        isAppClosed = true
                    }) {
                        Text("Close")
                            .foregroundColor(.blue)
                    }
                    .fullScreenCover(isPresented: $isAppClosed, content: {
                        // Vista de confirmación antes de cerrar la aplicación
                        VStack {
                            ZStack{
                                Color.white
                                    .edgesIgnoringSafeArea(.all)
                                VStack{
                                    Text("¿Are You Sure?")
                                        .font(.title)
                                        .padding()
                                        .foregroundColor(.primary)
                                    HStack {
                                        Button(action: {
                                            // Cierra la aplicación
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            exit(0)
                                        }) {
                                            Text("Yes")
                                                .padding()
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action: {
                                            isAppClosed = false // Cierra la vista de confirmación
                                        }) {
                                            Text("No")
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

