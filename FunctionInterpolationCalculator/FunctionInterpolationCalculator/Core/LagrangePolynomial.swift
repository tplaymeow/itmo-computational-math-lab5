struct LagrangePolynomial {
  let points: [Point]

  func callAsFunction(_ x: Double) -> Double {
    self.points.reduce(0) { sum, i in
      sum + i.y * self.points.reduce(1) { mult, j in
        i == j ? mult : mult * (x - j.x) / (i.x - j.x)
      }
    }
  }
}
