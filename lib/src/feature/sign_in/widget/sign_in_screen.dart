import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (mounted) {
        await context.router.replaceAll([const HomeRoute()]);
      }
    } on FirebaseAuthException catch (e) {
      String title;
      String description;
      switch (e.code) {
        case 'user-not-found':
          title = 'User not found';
          description = 'No user found for that email';
        case 'invalid-credential':
          title = 'Invalid credential';
          description = 'The email or password is invalid';
        case 'wrong-password':
          title = 'Wrong password';
          description = 'Wrong password provided for that user';
        case 'invalid-email':
          title = 'Invalid email';
          description = 'The email address is badly formatted';
        default:
          title = 'Something went wrong';
          description = e.message ?? 'An error occurred while signing in';
      }
      if (!mounted) return;
      ShadToaster.of(context).show(
        ShadToast(
          alignment: Alignment.topCenter,
          title: Text(title),
          description: Text(description),
          action: ShadButton.destructive(
            child: const Text('Dismiss'),
            onPressed: () => ShadToaster.of(context).hide(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SignInInfoCard(
                                color: Color(0xffFEF2E8),
                                icon: Icon(
                                  Icons.person,
                                  color: Color(0xffD38409),
                                ),
                                text: 'Increase Your Workflow',
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              flex: 3,
                              child: SignInInfoCard(
                                height: 100,
                                color: Color(0xffF2F0FE),
                                icon: Icon(
                                  Icons.check,
                                  color: Color(0xffA191F7),
                                ),
                                text: 'Attendance Management',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SignInInfoCard(
                                height: 100,
                                color: Color(0xffF1F8EC),
                                icon: Icon(
                                  Icons.money,
                                  color: Color(0xff72AB3A),
                                ),
                                text: 'Automatically Generate Payroll',
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              flex: 4,
                              child: SignInInfoCard(
                                height: 100,
                                color: Color(0xffEAEEF6),
                                icon: Icon(
                                  Icons.electrical_services_outlined,
                                  color: Color(0xff5C6476),
                                ),
                                text: 'Enhanced Data Accuracy',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Employee Management System',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            ShadInputFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              placeholder: const Text('Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            ShadInputFormField(
                              controller: passwordController,
                              placeholder: const Text('Password'),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShadButton(
                        size: ShadButtonSize.lg,
                        width: double.infinity,
                        onLongPress: () {
                          context.router.replaceAll([const HomeRoute()]);
                        },
                        onPressed: () async => await signIn(),
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class SignInInfoCard extends StatelessWidget {
  const SignInInfoCard({
    required this.color,
    required this.icon,
    required this.text,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;
  final Color color;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: icon,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}
