import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Schedule',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
          surfaceTintColor: Colors.transparent,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            ShadDatePicker(
              width: double.infinity,
              selected: selectedDate,
              closeOnSelection: true,
              onChanged: (date) {
                if (date == null) return;
                setState(() => selectedDate = date);
              },
            ),
          ],
        ),
      );
}
