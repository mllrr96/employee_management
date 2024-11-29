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
  final String name = FirebaseAuth.instance.currentUser?.displayName ?? '';

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
        color: Colors.white,
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
                      '$timeOfDay, $name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                    Text(
                      todayDate,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                  ],
                ),
                const ShadAvatar(
                  'assets/images/avatar.png',
                  size: Size(40, 40),
                ),
              ],
            ),
          ),
        ),
      );
}