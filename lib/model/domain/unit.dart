enum Unit{
  METER("m"),
  CENTIMETER("cm"),
  LITER("l"),
  MILLILITER("ml"),
  KILOGRAM("kg"),
  GRAM("g"),
  QUANTITY("szt."),
  PACK("kpl.");

  const Unit(this.shortName);
  final String shortName;
}

Unit? getUnitByName(String? name) {
  return name == null ? null : Unit.values.firstWhere((element) => element.shortName == name);
}