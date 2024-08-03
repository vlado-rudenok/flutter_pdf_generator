extension IntConvertible on double {
  double cmToInches() => this / 2.54;

  double mmToInches() => (this / 10).cmToInches();
}
