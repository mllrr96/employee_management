import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class GenerateReportsScreen extends StatefulWidget {
  const GenerateReportsScreen({super.key});

  @override
  State<GenerateReportsScreen> createState() => _GenerateReportsScreenState();
}

class _GenerateReportsScreenState extends State<GenerateReportsScreen> {
  List<String> employees = [
    'Ahmed Mahmood',
    'Mohammed Ali',
    'Adam Abdulraheman',
    'Lyan Majdi',
    'Mohammad Sajad',
  ];
  bool _isAllEmployees = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Platform.isIOS ? const CupertinoNavigationBarBackButton() : null,
          title: const Text(
            'Generate Payroll Reports',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Center(child: ShadCalendar.range()),
              const SizedBox(height: 12),
              Row(
                children: [
                  ShadSwitch(
                    value: _isAllEmployees,
                    label: const Text('Generate for all employees'),
                    onChanged: (value) {
                      setState(() {
                        _isAllEmployees = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (!_isAllEmployees)
                ShadSelect<String>.multiple(
                  showScrollToBottomChevron: true,
                  minWidth: double.infinity,
                  closeOnSelect: false,
                  itemCount: employees.length,
                  placeholder: const Text('Select employees'),
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
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.0, vertical: context.bottomPadding,),
          child: ShadButton(
            size: ShadButtonSize.lg,
            child: const Text('Generate Reports'),
            onPressed: () {
              context.router.push(const ReportsPreviewRoute());
            },
          ),
        ),
      );
}
