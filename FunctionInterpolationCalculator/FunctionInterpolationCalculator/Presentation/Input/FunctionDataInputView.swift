import SwiftUI

struct FunctionDataInputView: View {
  var body: some View {
    VStack {
      Form {
        Picker.init("Function", selection: self.$function) {
          ForEach(Function.allCases) { function in
            Text(function.displayString)
              .tag(function)
          }
        }

        TextField(
          "Interval From",
          value: self.$intervalFrom,
          formatter: self.numberFormatter
        )

        TextField(
          "Interval To",
          value: self.$intervalTo,
          formatter: self.numberFormatter
        )

        TextField(
          "Count",
          value: self.$count,
          formatter: self.numberFormatter
        )
      }

      HStack {
        Button("Done") {
          self.completion(linspace(
            from: min(self.intervalFrom, self.intervalTo),
            through: max(self.intervalFrom, self.intervalTo),
            in: self.count
          ).map {
            Point(x: $0, y: self.function($0))
          })
          self.dismiss()
        }

        Button("Cancel") {
          self.dismiss()
        }
      }
    }
    .padding()
  }

  init(completion: @escaping ([Point]) -> Void) {
    self.completion = completion
  }

  private let completion: ([Point]) -> Void

  @State
  private var function: Function = .function1

  @State
  private var intervalFrom: Double = 0.0

  @State
  private var intervalTo: Double = 1.0

  @State
  private var count: Int = 5

  @Environment(\.dismiss)
  private var dismiss

  private let numberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 4
    return formatter
  }()
}
