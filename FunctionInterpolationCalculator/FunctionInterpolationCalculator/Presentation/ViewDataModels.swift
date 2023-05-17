enum Model {
  case empty
  case content(ContentModel)
}

struct ContentModel {
  let points: [Point]
  let lagrange: LagrangeModel
  let gauss: GaussModel?
}

struct LagrangeModel {
  let polynomial: LagrangePolynomial
  let interpolated: [Point]
}

struct GaussModel {
  let polynomial: GaussPolynomial
  let interpolated: [Point]
}
