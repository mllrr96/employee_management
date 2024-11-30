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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ShadDatePicker(
                width: double.infinity,
                selected: selectedDate,
                closeOnSelection: true,
                onChanged: (date) {
                  if (date == null) return;
                  setState(() => selectedDate = date);
                },
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.alarm),
              title: Text('Work starts at 9:00 AM'),
            ),
            const ListTile(
              leading: Icon(Icons.alarm_off),
              title: Text('Work ends at 6:00 PM'),
            ),

          ],
        ),
      );
}
