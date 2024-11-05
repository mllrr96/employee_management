import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/feature/home/widget/check_widget.dart';
import 'package:employee_management/src/feature/home/widget/employee_app_bar.dart';
import 'package:flutter/material.dart';

/// {@template home_screen}
/// HomeScreen is a simple screen that displays a grid of items.
/// {@endtemplate}
@RoutePage()
class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: EmployeeAppBar(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: CheckWidget(color: Color(0xffF6F5FB))),
                  SizedBox(width: 10),
                  Expanded(child: CheckWidget(color: Color(0xffF6F5FB))),
                ],
              )
            ],
          ),
        )
      );
}
