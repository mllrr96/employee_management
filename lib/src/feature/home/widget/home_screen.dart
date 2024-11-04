import 'package:auto_route/auto_route.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Welcome,')
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () {
                      // context.router.push(SelectCoursesRoute());
                    }, label: const Text('Generate Schedule'), icon: const Icon(Icons.schedule)),
              ],
            ),
          )
        ],
      ),
    );
}
