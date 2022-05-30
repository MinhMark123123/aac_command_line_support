extension ClassName on String {
  String toFeatureName() {
    final splitter = this.split("_");
    var splitterFormatted =
        splitter.map((e) => e.replaceRange(0, 1, e[0].toUpperCase()));
    return splitterFormatted.join();
  }

  String toFeatureCamel() {
    final splitter = this.split("_");
    var splitterFormatted = splitter.asMap().map((key, value) {
      if (key == 0) return MapEntry(key, value);
      return MapEntry(key, value.replaceRange(0, 1, value[0].toUpperCase()));
    });
    return splitterFormatted.values.join();
  }
}
