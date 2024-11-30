import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:employee_management/src/core/routes/app_route.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? get name => FirebaseAuth.instance.currentUser?.displayName;

  String? get email => FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  ShadAvatar(
                    Assets.images.avatar.path,
                    size: const Size(120, 120),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (name != null)
                          Text(
                            name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (email != null)
                          Column(
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                email!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  ShadButton.outline(
                    size: ShadButtonSize.lg,
                    width: double.infinity,
                    onPressed: () async {
                      final result = await context.pushRoute(const UpdateProfileRoute());
                      if (result != null) {
                        setState(() {});
                      }
                    },
                    child: const Text('Update Profile'),
                  ),
                  ShadButton.outline(
                    size: ShadButtonSize.lg,
                    width: double.infinity,
                    onPressed: () =>
                        context.pushRoute(const ChangePasswordRoute()),
                    child: const Text('Change Password'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
