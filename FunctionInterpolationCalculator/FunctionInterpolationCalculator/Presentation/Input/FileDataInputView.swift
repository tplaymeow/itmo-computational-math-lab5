import SwiftUI
import AppKit
import CodableCSV

struct FileDataInputView: View {
  var body: some View {
    VStack {
      if let errorMessage = self.errorMessage {
        Text(errorMessage)
          .foregroundColor(.red)
      }

      Button("Open") {
        self.openFilePicker()
      }

      Button("Cancel") {
        self.dismiss()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .dropDestination(for: Data.self) { items, _ in
      self.processInput(data: items.first)
    }
  }

  init(input: Binding<[Point]>) {
    self._input = input
  }

  @Binding
  private var input: [Point]

  @State
  private var errorMessage: String?

  @Environment(\.dismiss)
  private var dismiss

  private func openFilePicker() {
    let panel = NSOpenPanel()
    panel.begin { _ in
      guard let url = panel.url else {
        return
      }

      self.processInput(
        data: try? Data(contentsOf: url)
      )
    }
  }

  @discardableResult
  private func processInput(data: Data?) -> Bool {
    guard let data else {
      self.errorMessage = "Can't read file"
      return false
    }

    let decoder = CSVDecoder { $0.headerStrategy = .firstLine }
    guard let points = try? decoder.decode([Point].self, from: data) else {
      self.errorMessage = "Incorrect file content"
      return false
    }

    self.input = points.unique()
    self.dismiss()

    return true
  }
}
