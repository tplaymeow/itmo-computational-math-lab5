extension Sequence {
  func slidingWindow2() -> some Sequence<(Element, Element)> {
    SlidingWindowSequence2(base: self)
  }
}

private struct SlidingWindowSequence2<
  BaseSequence: Sequence
>: Sequence {
  typealias Element = (
    BaseSequence.Element,
    BaseSequence.Element
  )

  init(base: BaseSequence) {
    self.base = base
  }

  func makeIterator() -> AnyIterator<Element> {
    var iterator = self.base.makeIterator()
    var last = iterator.next()
    return AnyIterator {
      guard let left = last else {
        return nil
      }
      guard let right = iterator.next() else {
        return nil
      }
      defer {
        last = right
      }
      return (left, right)
    }
  }

  private let base: BaseSequence
}
