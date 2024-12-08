import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:flutter/material.dart';

class CheckTypeDateWidget extends StatefulWidget {
  const CheckTypeDateWidget({
    required this.workTimes,
    super.key,
  });

  final WorkTimes workTimes;

  @override
  State<CheckTypeDateWidget> createState() => _CheckTypeDateWidgetState();
}

class _CheckTypeDateWidgetState extends State<CheckTypeDateWidget> {
  TimeOfDay? time;

  IconData get icon {
    switch (widget.workTimes) {
      case WorkTimes.startWork:
        return Icons.alarm;
      case WorkTimes.endWork:
        return Icons.alarm_off;
      case WorkTimes.startBreak:
        return EmployeeIcons.alarm_sleep;
      case WorkTimes.endBreak:
        return EmployeeIcons.alarm_sleep;
    }
  }

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () async {
          time = await showTimePicker(
            context: context,
            initialTime: time ?? TimeOfDay.now(),
          );
          setState(() {});
        },
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.isDarkMode
                ? Theme.of(context).scaffoldBackgroundColor
                : const Color(0xffF6F5FB),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: const Color(0xff403572),
              ),
              const SizedBox(width: 8),
              Text(
                widget.workTimes.name,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xff403572),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                time?.format(context) ?? 'Select Time',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: context.isDarkMode
                      ? Colors.white
                      : const Color(0xff403572),
                ),
              ),
            ],
          ),
        ),
      );
}

enum WorkTimes {
  startWork,
  endWork,
  startBreak,
  endBreak;

  String get name {
    switch (this) {
      case WorkTimes.startWork:
        return 'Start Work';
      case WorkTimes.endWork:
        return 'End Work';
      case WorkTimes.startBreak:
        return 'Start Break';
      case WorkTimes.endBreak:
        return 'End Break';
    }
  }
}
