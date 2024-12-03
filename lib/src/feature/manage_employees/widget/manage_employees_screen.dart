import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ManageEmployeesScreen extends StatelessWidget {
  const ManageEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Manage Employees',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: const Text('Employee Name'),
          ),
        ),
      );
}
