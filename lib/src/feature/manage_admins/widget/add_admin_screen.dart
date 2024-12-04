import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/feature/manage_admins/model/admin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class AddAdminScreen extends StatefulWidget {
  const AddAdminScreen({super.key, this.admin});

  final Admin? admin;

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
  bool get isEditing => widget.admin != null;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneNumberCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (isEditing) {
      nameCtrl.text = widget.admin!.name;
      emailCtrl.text = widget.admin!.email;
      addressCtrl.text = widget.admin!.address;
      phoneNumberCtrl.text = widget.admin!.phoneNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: Platform.isIOS
                ? const CupertinoNavigationBarBackButton()
                : null,
            title: const Text(
              'Add Admin',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: context.bottomPadding,
            ),
            child: ShadButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (isEditing) {
                    // Update admin
                  } else {
                    // Add admin
                  }
                }
              },
              child: isEditing
                  ? const Text('Update Admin')
                  : const Text('Add Admin'),
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
        ),
      );
}
