import 'package:auto_route/annotations.dart';
import 'package:employee_management/src/feature/manage_employees/model/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key, this.employee});

  final Employee? employee;

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  bool get isEditing => widget.employee != null;
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneNumberCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final rePasswordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ShadInputFormField(
                  controller: nameCtrl,
                  label: const Text('Name'),
                  placeholder: const Text('Enter name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12.0),
                ShadInputFormField(
                  controller: emailCtrl,
                  label: const Text('Email'),
                  placeholder: const Text('Enter email'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12.0),
                ShadInputFormField(
                  controller: addressCtrl,
                  label: const Text('Address'),
                  placeholder: const Text('Enter address'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12.0),
                ShadInputFormField(
                  controller: phoneNumberCtrl,
                  label: const Text('Phone Number'),
                  placeholder: const Text('Enter phone number'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                if (!isEditing)
                  Column(
                    children: [
                      const SizedBox(height: 12.0),
                      ShadInputFormField(
                        controller: passwordCtrl,
                        obscureText: true,
                        label: const Text('Password'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                        placeholder: const Text('Enter password'),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
}
