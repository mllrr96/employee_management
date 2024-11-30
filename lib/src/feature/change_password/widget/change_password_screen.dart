import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final reEnterNewPasswordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showOldPassword = false;
  bool showNewPassword = false;
  bool showReEnterNewPassword = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: Platform.isIOS
                ? const CupertinoNavigationBarBackButton()
                : null,
            title: const Text(
              'Change Password',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ShadInputFormField(
                    obscureText: showOldPassword,
                    controller: oldPasswordCtrl,
                    placeholder: const Text('Old Password'),
                    suffix: ShadButton(
                      height: 30,
                      width: 30,
                      onPressed: () => setState(
                            () => showOldPassword = !showOldPassword,
                      ),
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    validator: (value) {
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const Divider(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      ShadInputFormField(
                        obscureText: showNewPassword,
                        controller: newPasswordCtrl,
                        placeholder: const Text('New Password'),
                        suffix: ShadButton(
                          height: 30,
                          width: 30,
                          onPressed: () => setState(
                            () => showNewPassword = !showNewPassword,
                          ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.remove_red_eye),
                        ),
                        validator: (value) {
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ShadInputFormField(
                        obscureText: showReEnterNewPassword,
                        controller: reEnterNewPasswordCtrl,
                        placeholder: const Text('Re-enter New Password'),
                        suffix: ShadButton(
                          height: 30,
                          width: 30,
                          onPressed: () => setState(
                                () => showReEnterNewPassword = !showReEnterNewPassword,
                          ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.remove_red_eye),
                        ),
                        validator: (value) {
                          if (value != newPasswordCtrl.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: context.bottomPadding,
            ),
            child: ShadButton(
              child: const Text('Change Password'),
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                // Change password
                try {
                  await loading();
                  await FirebaseAuth.instance.currentUser
                      ?.reauthenticateWithCredential(
                    EmailAuthProvider.credential(
                      email: FirebaseAuth.instance.currentUser!.email!,
                      password: oldPasswordCtrl.text,
                    ),
                  );
                  await FirebaseAuth.instance.currentUser
                      ?.updatePassword(newPasswordCtrl.text);
                  if (context.mounted) {
                    // show success message
                    ShadToaster.of(context).show(
                      const ShadToast(
                        alignment: Alignment.topCenter,
                        title: Text('Success'),
                        description: Text('Password changed successfully.'),
                      ),
                    );
                    await context.maybePop();
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'wrong-password') {
                    if (context.mounted) {
                      ShadToaster.of(context).show(
                        const ShadToast.destructive(
                          title: Text('Error'),
                          description:
                              Text('The password provided is incorrect.'),
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      ShadToaster.of(context).show(
                        const ShadToast.destructive(
                          title: Text('Error'),
                          description:
                              Text('An error occurred. Please try again.'),
                        ),
                      );
                    }
                  }
                } finally {
                  await dismissLoading();
                }
              },
            ),
          ),
        ),
      );
}
