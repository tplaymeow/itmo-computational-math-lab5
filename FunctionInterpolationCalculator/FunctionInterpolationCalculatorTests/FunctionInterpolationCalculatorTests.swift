import XCTest
@testable
import FunctionInterpolationCalculator

final class FunctionInterpolationCalculatorTests: XCTestCase {
  func testBinomialCoefficients() throws {
    let gauss = try GaussPolynomial(points: [
      Point(x: 0.1, y: 1.25),
      Point(x: 0.2, y: 2.38),
      Point(x: 0.3, y: 3.79),
      Point(x: 0.4, y: 5.44),
      Point(x: 0.5, y: 7.14),

//      Point(x: 1940, y: 17),
//      Point(x: 1950, y: 20),
//      Point(x: 1960, y: 27),
//      Point(x: 1970, y: 32),
//      Point(x: 1980, y: 36),
//      Point(x: 1990, y: 38),
    ])

    print(gauss(0.32))
//    print(gauss(1976))
  }
}
