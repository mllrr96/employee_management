import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
// ignore: depend_on_referenced_packages
import 'package:ndef/ndef.dart' as ndef;
import 'package:shadcn_ui/shadcn_ui.dart';

class AddCheckModalSheet extends StatefulWidget {
  const AddCheckModalSheet({
    required this.checkType,
    required this.check,
    super.key,
  });

  final CheckType checkType;
  final Check check;

  @override
  State<AddCheckModalSheet> createState() => _AddCheckModalSheetState();
}

class _AddCheckModalSheetState extends State<AddCheckModalSheet> {
  CheckType get checkType => widget.checkType;
  final Duration _timeout = const Duration(seconds: 15);

  bool get newCheck => widget.check.id == null;
  late CheckBloc checkBloc;

  Check get check => widget.check;
  late Timer timer;
  bool isTimeout = false;

  String get infoText => isTimeout
      ? 'NFC session timed out'
      : 'Tap the NFC reader to ${checkType.name}';

  void addCheck(CheckType checkType) {
    setState(() => isTimeout = false);
    timer.cancel();
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

  Future<void> sendNfcData() async {
    // nfc session ends after 15 seconds
    timer = Timer(_timeout, () {
      setState(() => isTimeout = true);
    });
    try {
      await FlutterNfcKit.poll(
        timeout: _timeout,
        readIso18092: true,
      );

      await FlutterNfcKit.writeNDEFRecords([
        ndef.TextRecord(
          language: 'en',
          text: FirebaseAuth.instance.currentUser!.uid,
        ),
      ]);
    } catch (_) {
      if (mounted) setState(() => isTimeout = true);
    }
  }

  @override
  void initState() {
    checkBloc = CheckBloc.instance;
    sendNfcData();
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<CheckBloc, CheckState>(
        bloc: checkBloc,
        listener: (context, state) {
          state.mapOrNull(
            loaded: (_) {
              context.read<CheckBloc>().add(const CheckEvent.loadTodayCheck());
              context.router.popUntil(
                (route) => route.settings.name == DashboardRoute.name,
              );
            },
          );
        },
        builder: (context, state) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Opacity(
                opacity: isTimeout ? 0.1 : 1,
                child: GestureDetector(
                  onDoubleTap: () {
                    state.mapOrNull(
                      initial: (_) => addCheck(checkType),
                    );
                  },
                  child: state.maybeMap(
                    loading: (_) => LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                    error: (_) => const Text('Error occurred'),
                    orElse: () => Lottie.asset(
                      Assets.lottie.nfc,
                      animate: !isTimeout,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              infoText,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            if (isTimeout)
              ShadButton.destructive(
                width: double.infinity,
                size: ShadButtonSize.lg,
                child: const Text('Try again'),
                onPressed: () async {
                  setState(() {
                    isTimeout = false;
                  });
                  await sendNfcData();
                },
              ),
            if (!isTimeout)
              ShadButton.destructive(
                width: double.infinity,
                size: ShadButtonSize.lg,
                onPressed: state.mapOrNull(
                  initial: (_) => () => context.router.maybePop(),
                ),
                icon: state.mapOrNull(
                  loading: (_) => const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                child: state.maybeMap(
                  loading: (_) => const Text('Loading'),
                  orElse: () => const Text('Cancel'),
                ),
              ),
            SizedBox(
              height: context.bottomPadding,
            ),
          ],
        ),
      );
}
