import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/feature/manage_admins/model/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminInfoScreen extends StatelessWidget {
  const AdminInfoScreen({required this.admin, super.key});

  final Admin admin;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Admin Info',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
          actions: [
            ShadButton.ghost(
              onPressed: () => context.pushRoute(AddAdminRoute(admin: admin)),
              child: const Text('Edit'),
            ),
          ],
        ),
        body: Column(
          children: [
            ListTile(
              title: Text(admin.name),
              subtitle: Text(admin.email),
            ),
            ListTile(
              title: Text(admin.address),
              subtitle: Text(admin.phoneNumber),
            ),
          ],
        ),
      );
}
