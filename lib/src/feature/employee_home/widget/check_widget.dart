import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({required this.checkDetails, super.key});

  final CheckDetails checkDetails;

  @override
  Widget build(BuildContext context) {
    // format date time to 09:00 AM
    final String date = DateFormat('h:mm a').format(checkDetails.time);
    final Color color = checkDetails.color;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF6F5FB),
      ),
      height: 128,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: color,
              ),
              const SizedBox(width: 8),
              Text(
                checkDetails.type.name,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Flexible(
            child: Text(
              date,
              style: TextStyle(
                fontSize: 16,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddCheckWidget extends StatelessWidget {
  const AddCheckWidget({required this.check, super.key});

  final Check check;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => context.router.push(AddCheckRoute(check: check)),
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
