import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: GridView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 11,
            mainAxisSpacing: 11,
            childAspectRatio: 1.1,
          ),
          children: [
            AdminActionWidget(
              title: 'Generate Payroll Reports',
              icon: EmployeeIcons.report,
              color: const Color(0xff61598B),
              onTap: () => context.router.push(const GenerateReportsRoute()),
            ),
            AdminActionWidget(
              title: 'Manage Schedule',
              icon: EmployeeIcons.calendar,
              color: const Color(0xffFF3726),
              onTap: () {},
            ),
            AdminActionWidget(
              title: 'Manage Employees',
              icon: EmployeeIcons.employee_group,
              color: const Color(0xff479696),
              onTap: () {},
            ),
            AdminActionWidget(
              title: 'Manage Admins',
              icon: EmployeeIcons.admin,
              color: const Color(0xffFF5648),
              onTap: () {},
            ),
          ],
        ),
      );
}

class AdminActionWidget extends StatelessWidget {
  const AdminActionWidget({
    required this.title,
    required this.icon,
    required this.color,
    super.key,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Ink(
          width: 98,
          height: 90,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              // const SizedBox(height: 16),
              Icon(
                icon,
                color: color,
              ),
            ],
          ),
        ),
      );
}
