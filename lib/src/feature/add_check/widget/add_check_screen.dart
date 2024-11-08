import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class AddCheckScreen extends StatefulWidget {
  @override
  State<AddCheckScreen> createState() => _AddCheckScreenState();
}

class _AddCheckScreenState extends State<AddCheckScreen> {
  String time = DateFormat('h:mm:ss').format(DateTime.now());
  String amOrPm = DateFormat('a').format(DateTime.now());
  late Timer timer;
  // update time every second
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        time = DateFormat('h:mm:ss').format(DateTime.now());
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Add Check'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const CheckType(title: 'Clock In'),
              const SizedBox(height: 20),
              const CheckType(title: 'Clock Out'),
              const SizedBox(height: 20),
              const CheckType(title: 'Start Break'),
              const SizedBox(height: 20),
              const CheckType(title: 'End Break'),
              const Spacer(),
              Text(
                '$time $amOrPm',
                style:
                    const TextStyle(fontSize: 36, fontFamily: 'Inter', fontWeight: FontWeight.w500),
              ),
              const Spacer(),
            ],
          ),
        ),
      ));
}

class CheckType extends StatelessWidget {
  const CheckType({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset('assets/lottie/NFC.json'),
                  const Text(
                    'Tap the NFC reader',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ShadButton.destructive(
                    width: double.infinity,
                    size: ShadButtonSize.lg,
                    onPressed: () => context.router.maybePop(),
                    child: const Text('Cancel'),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewPadding.bottom)
                ],
              ),
            ),
          );
        },
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xffF6F5FB),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.alarm,
                color: Color(0xff403572),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: Color(0xff403572),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
}
