import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      appBar: AppBar(
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
                controller: oldPasswordCtrl,
                placeholder: const Text('Old Password'),
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
                    controller: newPasswordCtrl,
                    placeholder: const Text('New Password'),
                    validator: (value) {
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ShadInputFormField(
                    controller: reEnterNewPasswordCtrl,
                    placeholder: const Text('Re-enter New Password'),
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
        padding:
            EdgeInsets.symmetric(horizontal: 24.0, vertical: bottomPadding),
        child: ShadButton(
          child: const Text('Change Password'),
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;
            // Change password
            try {
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
                await context.maybePop();
              }
            } on FirebaseAuthException catch (e) {
              if (e.code == 'wrong-password') {
                if (context.mounted) {
                  ShadToaster.of(context).show(const ShadToast.destructive(
                    title: Text('Error'),
                    description: Text('The password provided is incorrect.'),
                  ),);
                }
              } else {
                if (context.mounted) {
                  ShadToaster.of(context).show(const ShadToast.destructive(
                    title: Text('Error'),
                    description: Text('An error occurred. Please try again.'),
                  ),);
                }
              }
            }
          },
        ),
      ),
    );
  }
}
