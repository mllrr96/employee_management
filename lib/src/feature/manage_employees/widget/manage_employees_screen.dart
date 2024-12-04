import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:employee_management/src/feature/manage_employees/model/employee_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ManageEmployeesScreen extends StatefulWidget {
  const ManageEmployeesScreen({super.key});

  @override
  State<ManageEmployeesScreen> createState() => _ManageEmployeesScreenState();
}

class _ManageEmployeesScreenState extends State<ManageEmployeesScreen> {
  List<Employee> employees = [
    Employee(
      name: 'Ahmed Ali',
      email: '1@1.com',
      address: '',
      phoneNumber: '',
    ),
    Employee(
      name: 'Lyan Majdi',
      email: '2@2.com',
      address: '',
      phoneNumber: '',
    ),
    Employee(
      name: 'Mohammad Sajad',
      email: '3@3.com',
      address: '',
      phoneNumber: '',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: Platform.isIOS
              ? const CupertinoNavigationBarBackButton()
              : null,
          title: const Text(
            'Manage Employees',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(9.0),
              child: Icon(EmployeeIcons.employee_group,
                color: Color(0xff479696),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.pushRoute(AddEmployeeRoute()),
          label: const Text('Add Employee'),
          icon: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            final employee = employees[index];
            return ListTile(
              onTap: () {},
              title: Text(employee.name),
              subtitle: Text(employee.email),
              trailing: const Icon(Icons.chevron_right),
            );
          },
        ),
      );
}
