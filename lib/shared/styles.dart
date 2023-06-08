import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

InputDecoration textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
);

DatesProperties currentDayStyle = DatesProperties(
  datesDecoration: DatesDecoration(
    //today view
    datesBackgroundColor: accent,
    datesBorderColor: Colors.transparent,
    datesTextColor: Colors.white,
  ),
);

DatesProperties selectedDayStyle = DatesProperties(
  datesDecoration: DatesDecoration(
    //today view
    datesBackgroundColor: accent.withAlpha(20),
    datesBorderColor: Colors.transparent,
    datesTextColor: Colors.black,
  ),
);

DatesProperties dayStyle = DatesProperties(
  datesDecoration: DatesDecoration(
    datesBackgroundColor: background,
    datesBorderColor: Colors.transparent,
    datesTextColor: Colors.black,
  ),
);

// TODO: Change or extend calendar lib. Event with dots!
DatesProperties dayEventsStyle = DatesProperties(
  datesDecoration: DatesDecoration(
    datesBackgroundColor: background,
    datesBorderColor: Colors.transparent,
    datesTextColor: Colors.green,
  ),
);

DatesProperties dayNotInMonthStyle = DatesProperties(
  datesDecoration: DatesDecoration(
    datesBackgroundColor: background,
    datesBorderColor: Colors.transparent,
  ),
);
