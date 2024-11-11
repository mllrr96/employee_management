import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
        ),
        body: Column(
          children: [
            ShadInputFormField(
              placeholder: const Text('Old Password'),
            ),
            const Divider(),
            ShadInputFormField(
              placeholder: const Text('New Password'),
            ),
            ShadInputFormField(
              placeholder: const Text('Re-enter New Password'),
            ),
          ],
        ),
      );
}
