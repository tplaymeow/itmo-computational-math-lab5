import SwiftUI

struct KeyboardDataInputView: View {
  var body: some View {
    VStack {
      Table(self.temporaryInput) {
        TableColumn("X") { item in
          Text(item.x.formatted())
        }

        TableColumn("Y") { item in
          Text(item.y.formatted())
        }
      }

      Form {
        TextField("X", value: self.$x, formatter: self.numberFormatter)

        TextField("Y", value: self.$y, formatter: self.numberFormatter)

        Button("Add point") {
          let point = Point(x: self.x, y: self.y)
          self.temporaryInput.append(point)
        }
      }

      HStack {
        Button("Done") {
          self.completion(self.temporaryInput.unique())
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
  private var x: Double = 0.0

  @State
  private var y: Double = 0.0

  @State
  private var temporaryInput: [Point] = []

  @Environment(\.dismiss)
  private var dismiss

  private let numberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 4
    return formatter
  }()
}
