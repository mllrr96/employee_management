import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/feature/employee_home/bloc/check_bloc.dart';
import 'package:employee_management/src/feature/employee_home/model/check.dart';
import 'package:employee_management/src/feature/employee_home/widget/check_widget.dart';
import 'package:employee_management/src/feature/employee_home/widget/employee_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    context.read<CheckBloc>().add(const CheckEvent.loadTodayCheck());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    );
    return BlocListener<CheckBloc, CheckState>(
      listener: (context, state) {
        state.mapOrNull(
          loaded: (_) => _refreshController.refreshCompleted(),
          error: (_) => _refreshController.refreshFailed(),
        );
      },
      child: Scaffold(
        appBar: EmployeeAppBar(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SmartRefresher(
          onRefresh: () {
            context.read<CheckBloc>().add(const CheckEvent.loadTodayCheck());
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: BlocBuilder<CheckBloc, CheckState>(
              builder: (context, state) => state.maybeMap(
                loaded: (state) {
                  final checkDetails = state.checks.first.checkDetails;
                  final canAddCheck = state.checks.first.end == null;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: gridDelegate,
                    itemCount: canAddCheck
                        ? checkDetails.length + 1
                        : checkDetails.length,
                    itemBuilder: (context, index) {
                      if (index == checkDetails.length && canAddCheck) {
                        return AddCheckWidget(check: state.checks.first);
                      }
                      final checkDetail = checkDetails[index];
                      return CheckWidget(checkDetails: checkDetail);
                    },
                  );
                },
                loading: (_) => GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: gridDelegate,
                  itemCount: 2,
                  itemBuilder: (context, index) => Skeletonizer(
                    child: CheckWidget(checkDetails: CheckDetails.empty()),
                  ),
                ),
                empty: (_) => GridView(
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
        ),
      ),
    );
  }
}
