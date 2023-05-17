extension Sequence {
  func scan<Result>(
    _ initialResut: Result,
    _ nextPatitialResult: (Result, Element) throws -> Result
  ) rethrows -> [Result] {
    try self.reduce(into: [initialResut]) { results, element in
      let result = results.last!
      let nextResut = try nextPatitialResult(result, element)
      results.append(nextResut)
    }
  }
}
