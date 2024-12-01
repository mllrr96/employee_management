import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class EmployeeAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<EmployeeAppBar> createState() => _EmployeeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EmployeeAppBarState extends State<EmployeeAppBar> {
  final String todayDate = DateFormat('d, MMMM y').format(DateTime.now());
  final String? name =
      FirebaseAuth.instance.currentUser?.displayName?.split(' ')[0];

  String get timeOfDay {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        height: kToolbarHeight + MediaQuery.of(context).viewPadding.top,
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name != null ? '$timeOfDay, $name' : 'Good $timeOfDay',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                    Text(
                      todayDate,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                  ],
                ),
                ShadAvatar(
                  Assets.images.avatar.path,
                  size: const Size(40, 40),
                ),
              ],
            ),
          ),
        ),
      );
}
