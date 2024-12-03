import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/feature/manage_admins/model/admin_model.dart';
import 'package:employee_management/src/feature/manage_admins/widget/admin_info_screen.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ManageAdminsScreen extends StatefulWidget {
  const ManageAdminsScreen({super.key});

  @override
  State<ManageAdminsScreen> createState() => _ManageAdminsScreenState();
}

class _ManageAdminsScreenState extends State<ManageAdminsScreen> {
  List<Admin> admins = [
    Admin(
      name: 'Mohammed Ragheb Mohsin',
      email: 'mr23025@auis.edu.krd',
      address: 'Sulaimani',
      phoneNumber: '0750 123 4567',
      id: '1',
    ),
    Admin(
      name: 'Ranj Mahmod',
      email: 'rm22023@auis.edu.krd',
      address: 'Sulaimani',
      phoneNumber: '0750 123 4567',
      id: '2',
    ),
    Admin(
      name: 'Bewar Barzan',
      email: 'bb22038@auis.edu.krd',
      address: 'Sulaimani',
      phoneNumber: '0750 123 4567',
      id: '3',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Manage Admins',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.pushRoute(AddAdminRoute()),
          icon: const Icon(Icons.add),
          label: const Text('Add Admin'),
        ),
        body: ListView.builder(
          itemCount: admins.length,
          itemBuilder: (context, index) {
            final admin = admins[index];
            return ListTile(
              onTap: () => showModalBottomSheet<Admin?>(
                context: context,
                builder: (context) => AdminInfoScreen(admin: admin),
              ),
              title: Text(admin.name),
              subtitle: Text(admin.email),
              trailing: const Icon(Icons.chevron_right),
            );
          },
        ),
      );
}
