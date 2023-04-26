import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Table(self.input) {
        TableColumn("X") { item in
          Text(item.x.formatted())
        }

        TableColumn("Y") { item in
          Text(item.y.formatted())
        }
      }

      Button("Import") {
        self.showDataInput = true
      }
    }
    .padding()
    .sheet(isPresented: self.$showDataInput) {
      DataInputView(input: self.$input)
        .frame(width: 500.0, height: 500.0)
    }
  }

  @State
  private var showDataInput: Bool = false

  @State
  private var input: [Point] = []
}
