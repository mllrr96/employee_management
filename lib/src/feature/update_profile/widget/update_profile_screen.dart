import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final String? name = FirebaseAuth.instance.currentUser?.displayName;
  final String? email = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    nameCtrl.text = name ?? '';
    emailCtrl.text = email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Profile',
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
              Stack(
                children: [
                  ShadAvatar(Assets.images.avatar.path,
                      size: const Size(120, 120),),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Colors.white, width: 2),),
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name'),
                    ShadInputFormField(
                      controller: nameCtrl,
                      placeholder: const Text('Full Name'),
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 10),
                    const Text('Email'),
                    ShadInputFormField(
                      controller: emailCtrl,
                      placeholder: const Text('Email Address'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    const Text('Phone Number'),
                    ShadInputFormField(
                      controller: phoneCtrl,
                      placeholder: const Text('Enter Your Phone Number '),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 10),
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
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              // Update profile
              if (nameCtrl.text != name) {
                await FirebaseAuth.instance.currentUser
                    ?.updateDisplayName(nameCtrl.text);
              }
              if (emailCtrl.text != email) {
                await FirebaseAuth.instance.currentUser
                    ?.verifyBeforeUpdateEmail(emailCtrl.text);
              }
              if (context.mounted) {
                await context.maybePop();
              }
            },
            child: const Text('Update'),
          ),
        ),
      ),
    );
  }
}
