enum AppFlavor {
  undefined('undefined'),
  prod('prod'),
  sim('sim');

  final String value;

  const AppFlavor(this.value);

  factory AppFlavor.fromValue(String value) =>
      values.firstWhere((x) => x.value == value, orElse: () => undefined);
}
