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