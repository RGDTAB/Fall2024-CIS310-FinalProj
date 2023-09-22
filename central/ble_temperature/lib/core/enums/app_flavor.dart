enum AppFlavor {
  undefined('undefined'),
  prod('prod'),
  sim('sim');

  const AppFlavor(this.value);
  factory AppFlavor.fromValue(String value) =>
      values.firstWhere((x) => x.value == value, orElse: () => undefined);
  final String value;
}
