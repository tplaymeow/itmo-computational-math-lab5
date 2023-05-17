struct FiniteDifferences {
  init(_ ys: [Double]) {
    self.storage = ys.indices.scan(ys) { prev, _ in
      prev.slidingWindow2().map { $1 - $0 }
    }
  }

  var table: [[Double]] {
    self.storage
  }

  subscript(forward i: Int, _ j: Int) -> Double {
    let offset = (self.storage[0].count - 1) / 2
    return self.storage[i][j + offset]
  }

  subscript(backward i: Int, _ j: Int) -> Double {
    let offset = self.storage[0].count / 2
    return self.storage[i][j + offset]
  }

  private let storage: [[Double]]
}
