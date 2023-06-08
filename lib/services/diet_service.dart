import 'package:supabase_flutter/supabase_flutter.dart';

class DietService {
  static final DietService _singleton = DietService._internal();

  factory DietService() => _singleton;

  DietService._internal();

  final supabase = Supabase.instance.client;

  Future<List<DateTime>> getAllMeals() async {
    DateTime today = DateTime.now();
    return [
      today.subtract(Duration(days: 1)),
      today,
      // today.add(Duration(days: 1)),
      today.add(Duration(days: 2)),
      today.add(Duration(days: 15)),
    ];
  }

  Future<List<String>> getMelasForDay(DateTime day) async {
    return ["Danie 1", "Danie 2", "Danie 3", "Danie 4"];
  }
}
