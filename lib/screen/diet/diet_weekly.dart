import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:paragony/screen/diet/util.dart';
import 'package:paragony/services/diet_service.dart';
import 'package:paragony/shared/error.dart';
import 'package:paragony/shared/loading.dart';
import 'package:paragony/shared/styles.dart';

class DietWeeklyWidget extends StatefulWidget {
  const DietWeeklyWidget({Key? key}) : super(key: key);

  @override
  State<DietWeeklyWidget> createState() => _DietWeeklyWidgetState();
}

class _DietWeeklyWidgetState extends State<DietWeeklyWidget> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCalendar(),
        _mealsListView(),
      ],
    );
  }

  Widget _buildCalendar() {
    return FutureBuilder(
      initialData: [],
      future: DietService().getAllMeals(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _calendarView([]);
        }

        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              return _calendarView(snapshot.data as List<DateTime>);
            }
          default:
            {
              return Loading();
            }
        }
      },
    );
  }

  Widget _calendarView(List<DateTime> datesForStreaks) {
    return CleanCalendar(
      startWeekday: WeekDay.monday,
      datePickerCalendarView: DatePickerCalendarView.weekView,
      weekdaysSymbol: weekdaysName,
      monthsSymbol: monthsName,
      selectedDates: [_selectedDay],
      onSelectedDates: (date) {
        setState(() {
          _selectedDay = date.first;
        });
      },
      dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
      datesForStreaks: datesForStreaks,
      currentDateProperties: currentDayStyle,
      selectedDatesProperties: selectedDayStyle,
      generalDatesProperties: dayStyle,
      streakDatesProperties: dayEventsStyle,
      leadingTrailingDatesProperties: dayNotInMonthStyle,
    );
  }

  Widget _mealsListView() {
    return FutureBuilder(
      initialData: [],
      future: DietService().getMelasForDay(_selectedDay),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return showError();
        }

        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              List<String> mealsList = snapshot.data as List<String>;

              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: mealsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(mealsList[index]),
                      onTap: () {},
                    );
                  });
            }
          default:
            {
              return Container();
            }
        }
      },
    );
  }
}
