import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
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
    context
        .read<CheckBloc>()
        .add(CheckEvent.loadChecks(id!, DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    );
    return Scaffold(
        appBar: EmployeeAppBar(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: BlocBuilder<CheckBloc, CheckState>(
            builder: (context, state) => state.maybeMap(
              loaded: (state) {
                final checkDetails = state.checks.first.checkDetails;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: gridDelegate,
                  itemCount: checkDetails.length == 4 ? checkDetails.length : checkDetails.length + 1,
                  itemBuilder: (context, index) {
                    if (index == checkDetails.length) {
                      return AddCheckWidget(check: state.checks.first);
                    }
                    final checkDetail = checkDetails[index];
                    return  CheckWidget( checkDetails: checkDetail);
                  },
                );
              },
              empty:(_) => GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: gridDelegate,
                children: [
                  AddCheckWidget(check: Check.empty()),
                ],
              ),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      );
  }
}
