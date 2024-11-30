import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ReportsPreviewScreen extends StatelessWidget {
  const ReportsPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports Preview',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(EmployeeIcons.excel),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reports Preview',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      '250 KB',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 24.0, vertical: bottomPadding),
        child: ShadButton(
          size: ShadButtonSize.lg,
          onPressed: () {},
          icon: const Icon(Icons.share),
          child: const Text('Share'),
        ),
      ),
    );
  }
}
