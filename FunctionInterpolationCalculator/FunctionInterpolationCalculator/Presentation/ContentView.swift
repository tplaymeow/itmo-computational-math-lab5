import SwiftUI
import Charts

struct ContentView: View {
  let model: ContentModel

  var body: some View {
    TabView {
      self.interpolateView
        .tabItem { Text("💻 Interpolate") }

      self.chartView
        .tabItem { Text("📉 Chart") }

      self.finiteDifferencesView
        .tabItem { Text("➖ Finite Differences") }
    }
  }

  @State
  private var interpolateX: Double = 3.0

  private let numberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 4
    return formatter
  }()

  @ViewBuilder
  private var interpolateView: some View {
    VStack {
      TextField("X", value: self.$interpolateX, formatter: self.numberFormatter)

      let lagrange = self.model.lagrange.polynomial
      Text("Lagrange Y: \(lagrange(self.interpolateX).formatted())")

      if let gauss = self.model.gauss?.polynomial {
        Text("Gauss Y: \(gauss(self.interpolateX).formatted())")
      }
    }
  }

  @ViewBuilder
  private var chartView: some View {
    Chart {
      ForEach(self.model.lagrange.interpolated) {
        LineMark(
          x: .value("X", $0.x),
          y: .value("Y", $0.y),
          series: .value("Type", "Lagrange")
        )
        .foregroundStyle(.red)
        .interpolationMethod(.cardinal)
      }

      if let gauss = self.model.gauss {
        ForEach(gauss.interpolated) {
          LineMark(
            x: .value("X", $0.x),
            y: .value("Y", $0.y),
            series: .value("Type", "Gauss")
          )
          .foregroundStyle(.blue)
          .lineStyle(.init(lineWidth: 2, dash: [10]))
          .interpolationMethod(.cardinal)
        }
      }

      ForEach(self.model.points) {
        PointMark(
          x: .value("X", $0.x),
          y: .value("Y", $0.y)
        )
        .foregroundStyle(.white)
      }
    }
    .chartForegroundStyleScale([
      "Lagrange": Color.red,
      "Gauss": Color.blue,
      "Y": Color.white,
    ])
    .foregroundStyle(Color.white)
  }

  @ViewBuilder
  private var finiteDifferencesView: some View {
    if let gauss = self.model.gauss {
      ScrollView([.horizontal, .vertical]) {
        HStack {
          ForEach(gauss.polynomial.differences.table, id: \.self) { row in
            VStack {
              ForEach(row, id: \.self) { number in
                Text(number.formatted())
              }
            }
          }
        }
      }
    } else {
      Text("😧 No data!")
    }
  }
}

/*
struct ContentView: View {
  var body: some View {
    VStack {
      if self.points.isEmpty {
        Button("Import") {
          self.showDataInput = true
        }
      } else {
        TabView {
          self.chartView
            .tabItem { Text("📉 Chart") }

          self.finiteDifferencesView
            .tabItem { Text("➖ Finite Differences") }
        }


        Button("Clear") {
          self.points = []
          self.lagrangeInterpolatedPoints = []
          self.gaussInterpolatedPoints = []
        }
      }
    }
    .padding()
    .sheet(isPresented: self.$showDataInput) {
      DataInputView(input: .init {
        self.points
      } set: { newPoints in
        guard self.points != newPoints else {
          return
        }

        self.points = newPoints
        self.interpolate()
      })
      .frame(width: 500.0, height: 500.0)
    }
  }

  @State
  private var showDataInput: Bool = false

  @State
  private var points: [Point] = []

  @State
  private var lagrangeInterpolatedPoints: [Point] = []
  @State
  private var lagrangePolynomial: LagrangePolynomial?

  @State
  private var gaussInterpolatedPoints: [Point] = []
  @State
  private var gaussPolynomial: GaussPolynomial?

  private var chartView: some View {
    Chart {
      ForEach(self.lagrangeInterpolatedPoints) {
        LineMark(
          x: .value("X", $0.x),
          y: .value("Y", $0.y),
          series: .value("Type", "Lagrange")
        )
        .foregroundStyle(.red)
        .interpolationMethod(.cardinal)
      }

      ForEach(self.gaussInterpolatedPoints) {
        LineMark(
          x: .value("X", $0.x),
          y: .value("Y", $0.y),
          series: .value("Type", "Gauss")
        )
        .foregroundStyle(.blue)
        .lineStyle(.init(lineWidth: 2, dash: [10]))
        .interpolationMethod(.cardinal)
      }

      ForEach(self.points) {
        PointMark(
          x: .value("X", $0.x),
          y: .value("Y", $0.y)
        )
        .foregroundStyle(.white)
      }
    }
    .chartForegroundStyleScale([
      "Lagrange": Color.red,
      "Gauss": Color.blue,
      "Y": Color.white,
    ])
    .foregroundStyle(Color.white)
  }

  @ViewBuilder
  private var finiteDifferencesView: some View {
    if let finiteDifferences = self.finiteDifferences {
      ScrollView([.horizontal, .vertical]) {
        HStack {
          ForEach(finiteDifferences.table, id: \.self) { row in
            VStack {
              ForEach(row, id: \.self) {
                Text($0.formatted())
              }
            }
          }
        }
      }
    } else {
      Text("😧 No data!")
    }
  }

  private func interpolate() {
    guard let intervalFrom = self.points.map(\.x).min(),
          let intervalTo = self.points.map(\.x).max() else {
      return
    }

    let intervalSize = intervalTo - intervalFrom
    guard intervalSize > 0 else {
      return
    }

    do {
      let function = LagrangePolynomial(points: self.points)
      self.lagrangeInterpolatedPoints = linspace(
        from: intervalFrom - 0.1 * intervalSize,
        through: intervalTo + 0.1 * intervalSize,
        in: 100
      ).map { x in
        Point(x: x, y: function(x))
      }
    }

    do {
      let function = try GaussPolynomial(points: self.points)
      self.finiteDifferences = function.differences
      self.gaussInterpolatedPoints = linspace(
        from: intervalFrom - 0.1 * intervalSize,
        through: intervalTo + 0.1 * intervalSize,
        in: 100
      ).map { x in
        Point(x: x, y: function(x))
      }
    } catch {
      self.finiteDifferences = nil
      self.gaussInterpolatedPoints = []
    }
  }
}
*/
