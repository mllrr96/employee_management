import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ManageScheduleScreen extends StatelessWidget {
  const ManageScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Manage Schedule',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
        ),
      ),
    ),
    body: const Center(
      child: Text('Manage Schedule'),
    ),
  );
}