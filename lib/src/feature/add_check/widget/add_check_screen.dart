import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:employee_management/src/feature/add_check/widget/add_check_modal_sheet.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
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

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: Platform.isIOS
              ? const CupertinoNavigationBarBackButton()
              : null,
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
                  checkType: CheckType.checkIn,
                  enabled: check.start == null,
                  check: check,
                ),
                const SizedBox(height: 20),
                CheckTypeWidget(
                  checkType: CheckType.checkOut,
                  enabled: canEndCheck,
                  check: check,
                ),
                const SizedBox(height: 20),
                CheckTypeWidget(
                  checkType: CheckType.breakStart,
                  enabled: check.start != null && check.breakStart == null,
                  check: check,
                ),
                const SizedBox(height: 20),
                CheckTypeWidget(
                  checkType: CheckType.breakEnd,
                  enabled: check.breakStart != null && check.breakEnd == null,
                  check: check,
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
      );
}

class CheckTypeWidget extends StatelessWidget {
  const CheckTypeWidget({
    required this.checkType,
    required this.check,
    super.key,
    this.enabled = true,
  });

  final CheckType checkType;
  final bool enabled;
  final Check check;

  IconData get icon {
    switch (checkType) {
      case CheckType.checkIn:
        return Icons.alarm;
      case CheckType.checkOut:
        return Icons.alarm_off;
      case CheckType.breakStart:
        return EmployeeIcons.alarm_sleep;
      case CheckType.breakEnd:
        return EmployeeIcons.alarm_sleep;
      case CheckType.done:
        return Icons.alarm;
      case CheckType.unknown:
        return Icons.alarm;
    }
  }

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !enabled,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () async {
              // check for nfc availability
              final availability = await FlutterNfcKit.nfcAvailability;
              if (availability == NFCAvailability.disabled) {
                if (!context.mounted) return;
                ShadToaster.of(context).show(
                  ShadToast.destructive(
                    title: const Text('NFC is not available'),
                    description:
                        const Text('Please enable NFC to use this feature'),
                    action: ShadButton.secondary(
                      onPressed: ShadToaster.of(context).hide,
                      child: const Text('Dismiss'),
                    ),
                  ),
                );
                return;
              }

              if (availability == NFCAvailability.not_supported) {
                if (!context.mounted) return;
                ShadToaster.of(context).show(
                  ShadToast.destructive(
                    title: const Text('NFC is not supported'),
                    description: const Text(
                      'This device does not support NFC. Please use a device that supports NFC to use this feature',
                    ),
                    action: ShadButton.secondary(
                      onPressed: ShadToaster.of(context).hide,
                      child: const Text('Dismiss'),
                    ),
                  ),
                );
                return;
              }

              if (!context.mounted) return;
              await showModalBottomSheet<String?>(
                isDismissible: false,
                context: context,
                builder: (context) => Container(
                  width: double.infinity,
                  height: context.height / 2,
                  padding: const EdgeInsets.all(20),
                  child: AddCheckModalSheet(checkType: checkType, check: check),
                ),
              );
            },
            child: Ink(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: context.isDarkMode
                    ? enabled
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.black12
                    : const Color(0xffF6F5FB),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xff403572),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    checkType.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      color: context.isDarkMode
                          ? enabled
                              ? Colors.white
                              : Colors.grey
                          : const Color(0xff403572),
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
