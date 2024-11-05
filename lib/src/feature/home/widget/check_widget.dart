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
                Icon(Icons.person, color: Color(0xff403572),),
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
