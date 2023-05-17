infix operator /+: MultiplicationPrecedence

func /+<Number>(
  _ a: Number,
  _ b: Number
) -> Number where Number: BinaryInteger {
  let (quotient, remainder) = a.quotientAndRemainder(dividingBy: b)
  return quotient + (remainder == 0 ? 0 : 1)
}
