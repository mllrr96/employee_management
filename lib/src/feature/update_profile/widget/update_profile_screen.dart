import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class UpdateProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile'),
        ),
        body: Column(
          children: [
            ShadAvatar(Assets.images.avatar),
            const Divider(),
            const Text('Name'),
            ShadInputFormField(
              placeholder: const Text('Full Name'),
            ),
            const SizedBox(height: 10),
            const Text('Email'),
            ShadInputFormField(
              placeholder: const Text('Email Address'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            const Text('Phone Number'),
            ShadInputFormField(
              placeholder: const Text('Enter Your Phone Number '),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
}
