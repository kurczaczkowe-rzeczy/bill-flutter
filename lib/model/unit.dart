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

  static Unit getValue(String name) {
    for (var unit in Unit.values) {
      if(unit.name == name){
        return unit;
      }
    }

    return QUANTITY;
  }
}