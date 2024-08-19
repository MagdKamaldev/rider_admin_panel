import 'package:flutter/material.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';

class ChangeShiftTimes extends StatefulWidget {
  final int riderId;
  const ChangeShiftTimes({super.key, required this.riderId});

  @override
  _ChangeShiftTimesState createState() => _ChangeShiftTimesState();
}

class _ChangeShiftTimesState extends State<ChangeShiftTimes> {
  TimeOfDay? _startTime;
  Duration _shiftDuration =
      Duration(hours: 1, minutes: 0); // Default 1 hour shift duration
  final _hoursController = TextEditingController();
  final _minutesController = TextEditingController();

  Future<void> _selectStartTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (time != null && time != _startTime) {
      setState(() {
        _startTime = time;
      });
    }
  }

  void _updateDuration() {
    final int? hours = int.tryParse(_hoursController.text);
    final int? minutes = int.tryParse(_minutesController.text);

    if (hours != null &&
        hours >= 0 &&
        hours < 24 &&
        minutes != null &&
        minutes >= 0 &&
        minutes < 60) {
      setState(() {
        _shiftDuration = Duration(hours: hours, minutes: minutes);
      });
    } else {
      // Handle invalid input, e.g., show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid hours and minutes.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with default values
    _hoursController.text = _shiftDuration.inHours.toString();
    _minutesController.text = (_shiftDuration.inMinutes % 60).toString();
  }

  @override
  Widget build(BuildContext context) {
    final endTime = _startTime != null ? _calculateEndTime() : null;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Shift Times',
          style: TextStyles.headings,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0)
              .copyWith(top: size.height * 0.05),
          child: SizedBox(
            width: size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/clock.png",
                    height: 100, width: 100, fit: BoxFit.cover),
                SizedBox(height: size.height * 0.06),
                TextButton(
                  onPressed: _selectStartTime,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: AppColors.prussianBlue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      _startTime != null
                          ? 'Start Time: ${_startTime!.format(context)}'
                          : 'Select Start Time',
                      style: TextStyles.headings,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                Text(
                  'Shift Duration:',
                  style: TextStyles.headings
                      .copyWith(color: AppColors.prussianBlue),
                ),
                SizedBox(height: size.height * 0.04),
                SizedBox(
                  width: size.width * 0.8 < 600 ? size.width * 0.8 : 600,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _hoursController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Hours',
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: (_) => _updateDuration(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _minutesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Minutes',
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                          ),
                          onChanged: (_) => _updateDuration(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.1),
                if (endTime != null)
                  Text(
                    'End Time: ${endTime.format(context)}',
                    style: TextStyles.headings
                        .copyWith(color: AppColors.prussianBlue),
                  ),
                SizedBox(height: size.height * 0.1),
                SizedBox(
                    width: size.width * 0.8 < 700 ? size.width * 0.8 : 700,
                    child: defaultButton(
                        function: () {}, context: context, text: "Confirm")),
                SizedBox(height: size.height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TimeOfDay? _calculateEndTime() {
    if (_startTime == null) return null;

    final startHour = _startTime!.hour;
    final startMinute = _startTime!.minute;

    final totalMinutes = _shiftDuration.inMinutes;
    final endHour = (startHour + totalMinutes ~/ 60) % 24;
    final endMinute = (startMinute + totalMinutes % 60) % 60;

    return TimeOfDay(hour: endHour, minute: endMinute);
  }
}
