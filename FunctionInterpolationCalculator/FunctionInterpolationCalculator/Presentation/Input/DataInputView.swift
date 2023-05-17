import SwiftUI

struct DataInputView: View {
  enum Mode {
    case keyboard
    case file
    case function
  }

  var body: some View {
    TabView(selection: self.$mode) {
      FileDataInputView(completion: self.completion)
        .tabItem {
          Text("File 📄")
        }
        .tag(Mode.file)

      KeyboardDataInputView(completion: self.completion)
        .tabItem {
          Text("Keyboard ⌨️")
        }
        .tag(Mode.keyboard)

      FunctionDataInputView(completion: self.completion)
        .tabItem {
          Text("Function 📈")
        }
        .tag(Mode.function)
    }
    .padding()
  }

  init(completion: @escaping ([Point]) -> Void) {
    self.completion = completion
  }

  private let completion: ([Point]) -> Void

  @State
  private var mode: Mode = .keyboard
}
