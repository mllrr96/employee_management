import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class AddCheckScreen extends StatefulWidget {
  const AddCheckScreen({required this.check, super.key});

  final Check check;

  @override
  State<AddCheckScreen> createState() => _AddCheckScreenState();
}

class _AddCheckScreenState extends State<AddCheckScreen> {
  Check get check => widget.check;

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
              CheckType(title: 'Clock In', enabled: check.start == null),
              const SizedBox(height: 20),
              CheckType(title: 'Clock Out', enabled: check.end == null),
              const SizedBox(height: 20),
              CheckType(
                title: 'Start Break',
                enabled: check.start != null && check.breakStart == null,
              ),
              const SizedBox(height: 20),
              CheckType(
                title: 'End Break',
                enabled: check.breakStart != null && check.breakEnd == null,
              ),
              const Spacer(),
              Text(
                '$time $amOrPm',
                style: const TextStyle(
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
            ],
          ),
        ),
      ));
}

class CheckType extends StatelessWidget {
  const CheckType({
    required this.title,
    super.key,
    this.enabled = true,
  });

  final String title;
  final bool enabled;

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !enabled,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: InkWell(
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
                      Lottie.asset(Assets.lottie.nfc),
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
                      SizedBox(
                          height: MediaQuery.of(context).viewPadding.bottom),
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
          ),
        ),
      );
}
