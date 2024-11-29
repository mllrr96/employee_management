import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/widget/check_widget.dart';
import 'package:employee_management/src/feature/employee_home/widget/employee_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final id = FirebaseAuth.instance.currentUser?.uid;
    context.read<CheckBloc>().add(CheckEvent.loadChecks('1234', DateTime.now()));
    super.initState();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: EmployeeAppBar(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<CheckBloc, CheckState>(
            builder: (context, state) => state.maybeMap(
              loaded: (state) {
                final check = state.checks.first;
                return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.checks.length,
                itemBuilder: (context, index) {
                  final check = state.checks[index];
                  return const CheckWidget(color: Color(0xffF6F5FB));
                },
              );
              },
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      );
}
