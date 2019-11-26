// * Will only be used in Calendar.dart! *

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final Map<DateTime, List> events;
  final Map<String, IconData> icons;

  AddEvent(this.events, this.icons);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  // Declare Variables
  Map<DateTime, List> _events;
  final TextEditingController _eventFilter = TextEditingController();

  // Date & Time Selector.
  DateTime _date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  void initState() {
    _events = widget.events;
    super.initState();
  }

  @override
  void dispose() {
    _eventFilter.dispose();
    super.dispose();
  }

  Widget _textField() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: TextField(
        controller: _eventFilter,
        onSubmitted: (text) {
          if (!(text == '')) {
            if (_events[_date] == null) {
              // If Null
              _events[_date] = []; // Create Empty List
            }
            if (_events[_date].isNotEmpty) {
              // If List has things inside
              _events[_date].add(_eventFilter.text); // Add the Text
            } else {
              _events[_date] = [
                _eventFilter.text
              ]; // Add the first item in list.
            }
            _eventFilter.clear();
            Future.delayed(Duration(milliseconds: 200)).then((_) {
              Navigator.of(context).pop();
            });
            setState(() {});
          }
        },
        textInputAction: TextInputAction.send,
        decoration: InputDecoration(
          helperText: 'Type in Event Name then press send',
          labelText: 'Event Name',
          suffixIcon: IconButton(
            onPressed: () {
              if (!(_eventFilter.text == '')) {
                if (_events[_date] == null) {
                  // If Null
                  _events[_date] = []; // Create Empty List
                }
                if (_events[_date].isNotEmpty) {
                  // If List has things inside
                  _events[_date].add(_eventFilter.text); // Add the Text
                } else {
                  _events[_date] = [
                    _eventFilter.text
                  ]; // Add the first item in list.
                }
                Future.delayed(Duration(milliseconds: 50)).then((_) {
                  FocusScope.of(context).unfocus();
                  _eventFilter.clear();
                });
                Future.delayed(Duration(milliseconds: 200)).then((_) {
                  Navigator.of(context).pop();
                });
                setState(() {});
              }
            },
            icon: Icon(Icons.send),
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _datePicker() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.calendar_today),
              ),
              InkWell(
                onTap: (() => _selectDate(context)),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(DateFormat('EEEE, MMMM d').format(_date))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Events'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              _datePicker(),
              _textField(),
            ],
          ),
        ],
      ),
    );
  }
}