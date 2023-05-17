import SwiftUI

struct MainView: View {
  var body: some View {
    VStack {
      switch self.model {
      case .empty:
        Button("Import") {
          self.showDataInput = true
        }

      case let .content(content):
        ContentView(model: content)

        Button("Clear") {
          self.model = .empty
        }
      }
    }
    .padding()
    .sheet(isPresented: self.$showDataInput) {
      DataInputView { points in
        self.interpolate(points: points)
      }
      .frame(width: 500.0, height: 500.0)
    }
  }

  @State
  private var model: Model = .empty

  @State
  private var showDataInput: Bool = false

  private func interpolate(points: [Point]) {
    guard let intervalFrom = points.map(\.x).min(),
          let intervalTo = points.map(\.x).max() else {
      self.model = .empty
      return
    }

    let intervalSize = intervalTo - intervalFrom
    guard intervalSize > 0 else {
      self.model = .empty
      return
    }

    let lagrangePolynomial = LagrangePolynomial(points: points)
    let lagrangeInterpolatedPoints = linspace(
      from: intervalFrom - 0.1 * intervalSize,
      through: intervalTo + 0.1 * intervalSize,
      in: 100
    ).map { x in
      Point(x: x, y: lagrangePolynomial(x))
    }
    let lagrange = LagrangeModel(
      polynomial: lagrangePolynomial,
      interpolated: lagrangeInterpolatedPoints
    )

    let gauss: GaussModel?
    do {
      let gaussPolynomial = try GaussPolynomial(points: points)
      let gaussInterpolatedPoints = linspace(
        from: intervalFrom - 0.1 * intervalSize,
        through: intervalTo + 0.1 * intervalSize,
        in: 100
      ).map { x in
        Point(x: x, y: gaussPolynomial(x))
      }
      gauss = GaussModel(
        polynomial: gaussPolynomial,
        interpolated: gaussInterpolatedPoints
      )
    } catch {
      gauss = nil
    }

    self.model = .content(ContentModel(
      points: points,
      lagrange: lagrange,
      gauss: gauss
    ))
  }
}
