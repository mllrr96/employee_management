import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
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

  bool get newCheck => widget.check.id == null;
  late CheckBloc checkBloc;

  Check get check => widget.check;

  @override
  void initState() {
    checkBloc = CheckBloc.instance;
    super.initState();
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
              child: GestureDetector(
                onTap: () {
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
                  orElse: () => Lottie.asset(Assets.lottie.nfc),
                ),
              ),
            ),
            // const Spacer(),
            Text(
              'Tap the NFC reader to ${checkType.name}',
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
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
