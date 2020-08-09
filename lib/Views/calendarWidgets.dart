import 'package:flutter/material.dart';
import 'package:househunter/Models/AppConstants.dart';

class CalendarMonthWidget extends StatefulWidget {

  final int monthIndex;
  final List<DateTime> bookedDates;
  final Function selectDate;
  final Function getSelectedDates;

  CalendarMonthWidget({Key key, this.monthIndex, this.bookedDates, this.selectDate, this.getSelectedDates}): super(key: key);

  @override
  _CalendarMonthState createState() => _CalendarMonthState();

}

class _CalendarMonthState extends State<CalendarMonthWidget>{

  List<DateTime> _selectedDates = [];
  List<MonthTile> _monthTiles;
  int _currentIntMonth;
  int _currentIntYear;

  void _setUpMonthTiles() {
    setState(() {
      _monthTiles = [];
      int daysInMonth = AppConstants.daysInMonths[_currentIntMonth];
      DateTime firstDayOfMonth = DateTime(_currentIntYear, _currentIntMonth, 1);
      int firstWeekdayOfMonth = firstDayOfMonth.weekday;
      if(firstWeekdayOfMonth != 7) {
        for(int i=0; i<firstWeekdayOfMonth; i++) {
          _monthTiles.add(MonthTile(dateTime: null,));
        }
      }
      for(int i=1; i<=daysInMonth; i++) {
        DateTime date = DateTime(_currentIntYear, _currentIntMonth, i);
        _monthTiles.add(MonthTile(dateTime: date,));
      }
    });

  }

  void _selectDate(DateTime date) {
    if(this._selectedDates.contains(date)) {
      this._selectedDates.remove(date);
    } else {
      this._selectedDates.add(date);
    }
    this._selectedDates.sort();
    widget.selectDate(date);
    setState(() {

    });
  }



  @override
  void initState() {
    _currentIntMonth = (DateTime.now().month + widget.monthIndex) % 12;
    if(_currentIntMonth == 0) {
      _currentIntMonth = 12;
    }
    _currentIntYear = DateTime.now().year;
    if(_currentIntYear < DateTime.now().month) {
      _currentIntYear += 1;
    }
    _selectedDates.addAll(widget.getSelectedDates());
    _setUpMonthTiles();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text("${AppConstants.monthDict[_currentIntMonth]} - $_currentIntYear"),
        ),
        GridView.builder(
          itemCount: _monthTiles.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1/1,
          ),
          itemBuilder: (context, index) {
            MonthTile monthTile = _monthTiles[index];
            if(monthTile.dateTime == null) {
              return MaterialButton(
                onPressed: null,
                child: Text(""),
              );
            }
            if(widget.bookedDates.contains(monthTile.dateTime)){
              return MaterialButton(
                onPressed: null,
                child: monthTile,
                color: Colors.yellow,
                disabledColor: Colors.yellow,
              );
            }
            return MaterialButton(
              onPressed: () {
                _selectDate(monthTile.dateTime);
              },
              child: monthTile,
              color: (this._selectedDates.contains(monthTile.dateTime)) ?
              Colors.blue :
              Colors.white,
            );
          },
        ),
      ],
    );
  }
}

class MonthTile extends StatelessWidget {

  final DateTime dateTime;

  MonthTile({this.dateTime, Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(this.dateTime == null ? "" : this.dateTime.day.toString());
  }

}