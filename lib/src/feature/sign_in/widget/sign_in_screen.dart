import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Lottie.asset('assets/lottie/account-1.json', repeat: false),
              ShadInputFormField(
                placeholder: const Text('Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              ShadInputFormField(
                placeholder: const Text('Password'),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              ShadButton(
                width: double.infinity,
                size: ShadButtonSize.lg,
                onPressed: () {
                  // context.router.push(const HomeScreenRoute());
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ));
}
