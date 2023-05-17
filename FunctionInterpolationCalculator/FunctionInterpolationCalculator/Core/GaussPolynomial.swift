struct GaussPolynomial {
  enum Error: Swift.Error {
    case incorrectPoints
  }

  init(points: [Point]) throws {
    guard points.count > 2 else {
      throw Error.incorrectPoints
    }

    guard points
      .map(\.x).slidingWindow2()
      .map(-).allEquals({ abs($0 - $1) < eps })
    else {
      throw Error.incorrectPoints
    }

    self.middlePointForward = points[(points.count - 1) / 2]
    self.middlePointBackward = points[points.count / 2]
    self.stepLength = points[1].x - points[0].x
    self.count = points.count
    self.differences = FiniteDifferences(
      points.map(\.y)
    )
  }

  let count: Int
  let stepLength: Double
  let middlePointForward: Point
  let middlePointBackward: Point
  let differences: FiniteDifferences

  var middlePoint: Point {
    .init(
      x: (self.middlePointForward.x + self.middlePointBackward.x) / 2,
      y: (self.middlePointForward.y + self.middlePointBackward.y) / 2
    )
  }

  func callAsFunction(_ x: Double) -> Double {
    let isForward = x > self.middlePoint.x
    let t = isForward
      ? (x - self.middlePointForward.x) / self.stepLength
      : (x - self.middlePointBackward.x) / self.stepLength

    var numerator = 1.0
    var denominator = 1.0
    var result = isForward
      ? self.middlePointForward.y
      : self.middlePointBackward.y

    for i in 1..<self.count {
      // Calculate finite difference
      let difference = isForward
        ? self.differences[forward: i, -(i / 2)]
        : self.differences[backward: i, -(i /+ 2)]

      // Calculate factorial
      denominator *= Double(i)

      // Calculate numerator
      switch (isForward, i.isMultiple(of: 2)) {
      case (false, true), (true, false):
        numerator *= t + Double((i - 1) /+ 2)
      case (false, false), (true, true):
        numerator *= t - Double((i - 1) /+ 2)
      }

      result += difference * numerator / denominator
    }

    return result
  }
}

private let eps: Double = 0.000000000001
