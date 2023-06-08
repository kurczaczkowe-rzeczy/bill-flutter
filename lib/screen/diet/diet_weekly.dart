import 'package:flutter/material.dart';

class DietWeeklyWidget extends StatelessWidget {
  const DietWeeklyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _horizontalListView();
  }

  Widget _horizontalListView() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (_, __) => Text('Jadłospis tygodniowy'),
      ),
    );
  }
}
