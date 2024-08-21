import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import the intl package
import 'package:tayar_admin_panel/core/service_locator/service_locator.dart';
import 'package:tayar_admin_panel/core/themes/colors.dart';
import 'package:tayar_admin_panel/core/themes/components.dart';
import 'package:tayar_admin_panel/core/themes/text_styles.dart';
import 'package:tayar_admin_panel/features/riders/data/repos/riders_repo_impl.dart';
import 'package:tayar_admin_panel/features/riders/logic/cubit/rider_cubit.dart';
import 'package:tayar_admin_panel/generated/l10n.dart';

class ChangeShiftTimes extends StatefulWidget {
  final int riderId;
  const ChangeShiftTimes({super.key, required this.riderId});

  @override
  ChangeShiftTimesState createState() => ChangeShiftTimesState();
}

class ChangeShiftTimesState extends State<ChangeShiftTimes> {
  TimeOfDay? _startTime;
  Duration _shiftDuration =
      const Duration(hours: 1, minutes: 0); // Default 1 hour shift duration
  final _hoursController = TextEditingController();
  final _minutesController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        SnackBar(content: Text(S.of(context).invalidTimeInput)),
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

    return BlocProvider(
      create: (context) => RiderCubit(getIt<RiderRepoImpl>()),
      child: BlocBuilder<RiderCubit, RiderState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).changeShiftTimes,
                style: TextStyles.headings,
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0)
                      .copyWith(top: size.height * 0.05),
                  child: SizedBox(
                    width: size.width,
                    child: Column(
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
                                  ? '${S.of(context).startTime}: ${_startTime!.format(context)}'
                                  : S.of(context).selectStartTime,
                              style: TextStyles.headings,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.1),
                        Text(
                          S.of(context).shiftDuration,
                          style: TextStyles.headings
                              .copyWith(color: AppColors.prussianBlue),
                        ),
                        SizedBox(height: size.height * 0.04),
                        SizedBox(
                          width:
                              size.width * 0.8 < 600 ? size.width * 0.8 : 600,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _hoursController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).hours,
                                    border: const OutlineInputBorder(),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  onChanged: (_) => _updateDuration(),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _minutesController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: S.of(context).minutes,
                                    border: const OutlineInputBorder(),
                                    contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 12),
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
                            '${S.of(context).endTime}: ${endTime.format(context)}',
                            style: TextStyles.headings
                                .copyWith(color: AppColors.prussianBlue),
                          ),
                        SizedBox(height: size.height * 0.1),
                        if (state is ChangeRiderShiftTimeLoading)
                          const Center(child: CircularProgressIndicator()),
                        if (state is! ChangeRiderShiftTimeLoading)
                          SizedBox(
                              width: size.width * 0.8 < 700
                                  ? size.width * 0.8
                                  : 700,
                              child: defaultButton(
                                  function: () {
                                    if (_startTime == null || endTime == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              S.of(context).selectStartTime),
                                        ),
                                      );
                                      return;
                                    } else {
                                      if (_formKey.currentState!.validate()) {
                                        final startDateTime = _timeOfDayToDateTime(
                                            _startTime!);
                                        final endDateTime =
                                            _timeOfDayToDateTime(endTime);

                                        context.read<RiderCubit>().changeRiderShiftTime(
                                            widget.riderId,
                                            startDateTime,
                                            endDateTime,
                                            _shiftDuration,context);
                                      }
                                    }
                                  },
                                  context: context,
                                  text: S.of(context).confirm)),
                        SizedBox(height: size.height * 0.06),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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

  DateTime _timeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }
}