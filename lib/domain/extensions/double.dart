extension DoubleExtenstions on double {
  /// Parses the value to fixed length
  ///
  /// ### Example
  ///
  ///     3.14159265359.withLengthOf(3);
  ///
  /// Will output 3.14
  double withLengthOf(int length) {
    return double.parse(toStringAsFixed(length));
  }
}
