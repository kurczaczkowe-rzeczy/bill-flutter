import 'dart:developer';

import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:paragony/shared/colors.dart';

class DietWeeklyWidget extends StatefulWidget {
  const DietWeeklyWidget({Key? key}) : super(key: key);

  @override
  State<DietWeeklyWidget> createState() => _DietWeeklyWidgetState();
}

class _DietWeeklyWidgetState extends State<DietWeeklyWidget> {
  DateTime selectedDay = DateTime(2023, 6, 7);

  @override
  Widget build(BuildContext context) {
    return _horizontalListView();
  }

  Widget _horizontalListView() {
    return CleanCalendar(
      startWeekday: WeekDay.monday,
      datePickerCalendarView: DatePickerCalendarView.weekView,
      weekdaysSymbol: const Weekdays(
          sunday: "Nie",
          monday: "Pon",
          tuesday: "Wt",
          wednesday: "Śr",
          thursday: "Czw",
          friday: "Pt",
          saturday: "Sob"),
      monthsSymbol: const Months(
          january: "Styczeń",
          february: "Luty",
          march: "Marzec",
          april: "Kwiecień",
          may: "Maj",
          june: "Czerwiec",
          july: "Lipiec",
          august: "Sierpień",
          september: "Wrzesień",
          october: "Październik",
          november: "Listopad",
          december: "Grudzień"),
      selectedDates: [selectedDay],
      onSelectedDates: (date) {
        log('onSelectedDates $date');
        setState(() {
          selectedDay = date.first;
        });
      },
      onCalendarViewDate: (date) => log('onCalendarViewDate $date'),
      dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
      datesForStreaks: [DateTime(2023, 6, 9)],
      currentDateProperties: DatesProperties(
        datesDecoration: DatesDecoration(
          //today view
          datesBackgroundColor: accent,
          datesBorderColor: Colors.transparent,
          datesTextColor: Colors.white,
        ),
      ),
      selectedDatesProperties: DatesProperties(
        //selected day
        datesDecoration: DatesDecoration(
          //today view
          datesBackgroundColor: accent.withAlpha(20),
          datesBorderColor: Colors.transparent,
          datesTextColor: Colors.black,
        ),
      ),
      generalDatesProperties: DatesProperties(
        //all days in month
        datesDecoration: DatesDecoration(
          datesBackgroundColor: background,
          datesBorderColor: Colors.transparent,
          datesTextColor: Colors.black,
        ),
      ),
      // TODO: Change or extend calendar lib. Event with dots!
      streakDatesProperties: DatesProperties(
        //days with events
        datesDecoration: DatesDecoration(
          datesBackgroundColor: background,
          datesBorderColor: Colors.transparent,
          datesTextColor: Colors.green,
        ),
      ),
      leadingTrailingDatesProperties: DatesProperties(
        //days not in month
        datesDecoration: DatesDecoration(
          datesBackgroundColor: background,
          datesBorderColor: Colors.transparent,
        ),
      ),
    );
  }
}
