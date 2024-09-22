import SwiftUI

struct ContentView: View {
    // State properties to hold the calculator display and calculation state
    @State private var display = "0"
    @State private var firstNumber: Double? = nil
    @State private var operation: String? = nil
    
    // Array of button labels for the calculator grid
    let buttons = [
        
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["0", ".", "=", "+"],
        ["C"]
    ]
    
    var body: some View {
        VStack {
            // Display the calculator result or input
            Text(display)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
            // Buttons for the calculator
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.title)
                                .frame(width: 70, height: 70)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(35)
                                .padding(5)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    // Handle button tap events
    func buttonTapped(_ button: String) {
        if button == "C" {
            // Clear the display and reset the calculation state
            display = "0"
            firstNumber = nil
            operation = nil
        } else if let num = Double(button) {
            // If the display is "0", replace it with the tapped number
            if display == "0" || (operation != nil && firstNumber == nil) {
                display = "\(num)"
            } else {
                display += "\(num)"
            }
        } else if button == "." {
            // Add a decimal point to the display
            if !display.contains(".") {
                display += "."
            }
        } else if ["+", "-", "*", "/"].contains(button) {
            // Store the first number and operation
            firstNumber = Double(display)
            operation = button
            display = ""
        } else if button == "=" {
            // Perform the calculation
            if let firstNum = firstNumber, let secondNum = Double(display), let op = operation {
                let result: Double
                switch op {
                case "+":
                    result = firstNum + secondNum
                case "-":
                    result = firstNum - secondNum
                case "*":
                    result = firstNum * secondNum
                case "/":
                    result = firstNum / secondNum
                default:
                    result = 0
                }
                display = "\(result)"
                firstNumber = nil
                operation = nil
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
