struct Point {
  let x: Double
  let y: Double
}

extension Point: Codable { }

extension Point: Hashable { }

extension Point: SelfIdentifiable { }
