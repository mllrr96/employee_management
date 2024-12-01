import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/utils/loading.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  bool get canEndCheck =>
      check.end == null &&
      check.start != null &&
      (check.breakStart == null ||
          (check.breakStart != null && check.breakEnd != null));


  bool get newCheck => check.id == null;

  String time = DateFormat('h:mm:ss').format(DateTime.now());
  String amOrPm = DateFormat('a').format(DateTime.now());
  late Timer timer;
  late CheckBloc checkBloc;

  // update time every second
  @override
  void initState() {
    checkBloc = CheckBloc.instance;
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

  void addCheck(CheckType checkType) {
    if (newCheck) {
      checkBloc.add(
        CheckEvent.createCheck(
          check.copyWith(
            employeeId: FirebaseAuth.instance.currentUser!.uid,
            start: DateTime.now(),
            date: DateTime.now(),
          ),
        ),
      );
    } else {
      Check updatedCheck;
      switch (checkType) {
        case CheckType.checkIn:
          updatedCheck = check.copyWith(
            start: DateTime.now(),
          );
        case CheckType.checkOut:
          updatedCheck = check.copyWith(
            end: DateTime.now(),
          );
        case CheckType.breakStart:
          updatedCheck = check.copyWith(
            breakStart: DateTime.now(),
          );
        case CheckType.breakEnd:
          updatedCheck = check.copyWith(
            breakEnd: DateTime.now(),
          );
        default:
          return;
      }
      checkBloc.add(
        CheckEvent.updateCheck(
          check.id!,
          updatedCheck.copyWith(
            employeeId: FirebaseAuth.instance.currentUser!.uid,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocListener<CheckBloc, CheckState>(
        bloc: checkBloc,
        listener: (context, state) {
          state.map(
            initial: (_) {},
            loaded: (_) {
              dismissLoading();
              context.read<CheckBloc>().add(const CheckEvent.loadTodayCheck());
              context.router.popUntil(
                (route) => route.settings.name == DashboardRoute.name,
              );
            },
            loading: (_) {
              loading();
            },
            empty: (_) {
              context.read<CheckBloc>().add(const CheckEvent.loadTodayCheck());
              context.maybePop();
            },
            error: (e) {
              dismissLoading();
              ShadToaster.of(context).show(
                ShadToast.destructive(
                  title: const Text('Failed to add check'),
                  description: Text(e.message),
                ),
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Check',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CheckTypeWidget(
                    title: 'Clock In',
                    enabled: check.start == null,
                    onTap: () => addCheck(CheckType.checkIn),
                  ),
                  const SizedBox(height: 20),
                  CheckTypeWidget(
                    title: 'Clock Out',
                    enabled: canEndCheck,
                    onTap: () => addCheck(CheckType.checkOut),
                  ),
                  const SizedBox(height: 20),
                  CheckTypeWidget(
                    title: 'Start Break',
                    enabled: check.start != null && check.breakStart == null,
                    onTap: () => addCheck(CheckType.breakStart),
                  ),
                  const SizedBox(height: 20),
                  CheckTypeWidget(
                    title: 'End Break',
                    enabled: check.breakStart != null && check.breakEnd == null,
                    onTap: () => addCheck(CheckType.breakEnd),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          time,
                          style: const TextStyle(
                            fontSize: 36,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          amOrPm,
                          style: const TextStyle(
                            fontSize: 36,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
}

class CheckTypeWidget extends StatelessWidget {
  const CheckTypeWidget({
    required this.title,
    super.key,
    this.enabled = true,
    this.onTap,
  });

  final String title;
  final bool enabled;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !enabled,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              showModalBottomSheet<String?>(
                isDismissible: false,
                context: context,
                builder: (context) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onTap,
                        child: Lottie.asset(Assets.lottie.nfc),
                      ),
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
                        height: context.bottomPadding,
                      ),
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
