import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({required this.color, super.key});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        height: 128,
        padding: const EdgeInsets.all(20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color(0xff403572),
                ),
                SizedBox(width: 8),
                Text(
                  'Check In',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff403572),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Flexible(
              child: Text(
                '09:00 AM',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
}

class AddCheckWidget extends StatelessWidget {
  const AddCheckWidget({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => context.router.push(const AddCheckRoute()),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xff479696).withOpacity(0.1),
          ),
          height: 128,
          padding: const EdgeInsets.all(20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 40,
                color: Color(0xff479696),
              ),
              SizedBox(height: 12),
              Text(
                'Add Check',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff479696),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
}
