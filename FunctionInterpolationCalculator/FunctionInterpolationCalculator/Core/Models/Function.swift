import Foundation

enum Function: CaseIterable {
  case function1
  case function2
  case function3
}

extension Function {
  var displayString: String {
    switch self {
    case .function1:
      return "sin(x)"
    case .function2:
      return "ln(x)"
    case .function3:
      return "e^sin(x)"
    }
  }
}

extension Function {
  func callAsFunction(_ x: Double) -> Double {
    switch self {
    case .function1:
      return sin(x)
    case .function2:
      return log(x)
    case .function3:
      return exp(sin(x))
    }
  }
}

extension Function: Equatable { }

extension Function: Hashable { }

extension Function: SelfIdentifiable { }
