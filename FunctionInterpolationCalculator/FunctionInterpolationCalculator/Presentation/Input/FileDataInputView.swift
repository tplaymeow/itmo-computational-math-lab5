import SwiftUI
import AppKit
import CodableCSV

struct FileDataInputView: View {
  var body: some View {
    Button("Open") {
      self.importData()
    }
    .padding()
  }

  init(input: Binding<[Point]>) {
    self._input = input
  }

  @Binding
  private var input: [Point]

  @Environment(\.dismiss)
  private var dismiss

  func importData() {
    let panel = NSOpenPanel()
    panel.begin { _ in
      guard let url = panel.url else {
        return
      }

      guard let data = try? Data(contentsOf: url) else {
        return
      }

      let decoder = CSVDecoder { $0.headerStrategy = .firstLine }
      guard let points = try? decoder.decode([Point].self, from: data) else {
        return
      }

      self.input = points.unique()
      self.dismiss()
    }
  }
}
