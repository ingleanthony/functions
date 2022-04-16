//
//  HelperFunctions.swift
//  Calculator
//
//  Created by Anthony Ingle on 4/14/22.
//

import SwiftUI
import Expression

struct History: Identifiable {
    let id = UUID()
    var expression: String
    var solution: String
}

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 // maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

func evaluateExpression(_ givenExpression: String) throws -> Double {
    var solution: Double = 0;
    
    // ability to use ^ as a power operator
    let expression = Expression(givenExpression, symbols: [
        .infix("^"): { params in pow(params[0], params[1]) },
    ])
    solution = try expression.evaluate()
    
    return solution;
}

struct CalcButtonStyle: ButtonStyle {
  var foregroundColor: Color
  var backgroundColor: Color
  var pressedColor: Color

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .frame(height: 20)
      .frame(maxWidth: .infinity)
      .foregroundColor(foregroundColor)
      .background(configuration.isPressed ? .tertiary : .quaternary)
      .cornerRadius(5)
  }
}

extension View {
  func calcButton(
    foregroundColor: Color = .white,
    backgroundColor: Color = .gray,
    pressedColor: Color = .accentColor
  ) -> some View {
    self.buttonStyle(
      CalcButtonStyle(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        pressedColor: pressedColor
      )
    )
  }
}
