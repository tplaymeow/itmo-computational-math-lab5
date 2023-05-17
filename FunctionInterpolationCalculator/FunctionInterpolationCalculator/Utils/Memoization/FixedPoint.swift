public func fixedPoint<Input, Output>(
  _ function: @escaping ((Input) -> Output, Input) -> Output
) -> (Input) -> Output {
  { input in
    function(fixedPoint(function), input)
  }
}
