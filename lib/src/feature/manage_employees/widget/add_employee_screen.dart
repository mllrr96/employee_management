import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class AddEmployeeScreen extends StatelessWidget {
  const AddEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Employee',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Column(
          children: [
            ShadInputFormField(
              label: const Text('Name'),
              placeholder: const Text('Enter name'),
            ),
            ShadInputFormField(
              label: const Text('Email'),
              placeholder: const Text('Enter email'),
            ),
            ShadInputFormField(
              label: const Text('Address'),
              placeholder: const Text('Enter address'),
            ),
            ShadInputFormField(
              label: const Text('Phone Number'),
              placeholder: const Text('Enter phone number'),
            ),
            ShadInputFormField(
              label: const Text('Password'),
              placeholder: const Text('Enter password'),
            ),
            ShadInputFormField(
              label: const Text('Re-enter Password'),
              placeholder: const Text('Re-enter password'),
            ),
          ],
        ),
      );
}
