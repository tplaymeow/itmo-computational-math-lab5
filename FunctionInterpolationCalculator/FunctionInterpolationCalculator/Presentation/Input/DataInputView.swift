import SwiftUI

struct DataInputView: View {
  enum Mode {
    case keyboard
    case file
    case function
  }

  var body: some View {
    TabView(selection: self.$mode) {
      FileDataInputView(input: self.$input)
        .tabItem {
          Text("File 📄")
        }
        .tag(Mode.file)

      KeyboardDataInputView(input: self.$input)
        .tabItem {
          Text("Keyboard ⌨️")
        }
        .tag(Mode.keyboard)

      FunctionDataInputView(input: self.$input)
        .tabItem {
          Text("Function 📈")
        }
        .tag(Mode.function)
    }
    .padding()
  }

  init(input: Binding<[Point]>) {
    self._input = input
  }

  @State
  private var mode: Mode = .keyboard

  @Binding
  private var input: [Point]
}
