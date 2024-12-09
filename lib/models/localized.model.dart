class Localized {
  Map<String, String> localizedMap;

  Localized(this.localizedMap);

  String operator [](String label) => localizedMap[label] ?? '';

  void operator []=(String label, String value) {
    localizedMap[label] = value;
  }
}