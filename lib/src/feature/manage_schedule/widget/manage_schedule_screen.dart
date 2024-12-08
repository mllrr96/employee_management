import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/utils/extensions/string_extension.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:employee_management/src/feature/manage_schedule/widget/check_type_date_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ManageScheduleScreen extends StatefulWidget {
  const ManageScheduleScreen({super.key});

  @override
  State<ManageScheduleScreen> createState() => _ManageScheduleScreenState();
}

class _ManageScheduleScreenState extends State<ManageScheduleScreen> {
  List<String> employees = [
    'Ahmed Mahmood',
    'Mohammed Ali',
    'Adam Abdulraheman',
    'Lyan Majdi',
    'Mohammad Sajad',
  ];
  List<String> days = [
    'Saturdays',
    'Sundays',
    'Mondays',
    'Tuesdays',
    'Wednesdays',
    'Thursdays',
    'Fridays',
  ];

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: Platform.isIOS
                ? const CupertinoNavigationBarBackButton()
                : null,
            title: const Text(
              'Manage Schedule',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(EmployeeIcons.calendar, color: Color(0xffFF3726)),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.router.maybePop(),
            label: const Text('Update'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ShadSelect<String>(
                  initialValue: 'Saturdays',
                  showScrollToBottomChevron: true,
                  minWidth: double.infinity,
                  placeholder: const Text('Select days'),
                  options: days.map(
                    (e) => ShadOption(
                      value: e,
                      child: Text(e),
                    ),
                  ),
                  selectedOptionsBuilder: (BuildContext context, values) =>
                      Text(values.map((v) => v.capitalize).join(', ')),
                ),
                const SizedBox(height: 12),
                ShadSelect<String>(
                  showScrollToBottomChevron: true,
                  minWidth: double.infinity,
                  placeholder: const Text('Select employee'),
                  options: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(32, 6, 6, 6),
                      child: Text(
                        'Employees',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...employees.map(
                      (e) => ShadOption(
                        value: e,
                        child: Text(e),
                      ),
                    ),
                  ],
                  selectedOptionsBuilder: (BuildContext context, values) =>
                      Text(values.map((v) => v.capitalize).join(', ')),
                ),
                const Divider(height: 30,),
                ...List.generate(
                  4,
                  (index) =>
                      Column(
                        children: [
                          CheckTypeDateWidget(workTimes: WorkTimes.values[index]),
                          const SizedBox(height: 12),
                        ],
                      ),
                ),
              ],
            ),
          ),
        ),
      );
}
