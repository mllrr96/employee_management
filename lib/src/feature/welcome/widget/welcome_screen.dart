import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SignInInfoCard(
                                color: const Color(0xffFEF2E8),
                                icon: const Icon(
                                  Icons.person,
                                  color: Color(0xffD38409),
                                ),
                                text: 'Increase Your Workflow',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              flex: 3,
                              child: SignInInfoCard(
                                height: 100,
                                color: const Color(0xffF2F0FE),
                                icon: const Icon(
                                  Icons.add_chart,
                                  color: Color(0xffA191F7),
                                ),
                                text: 'Attendance Management',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: SignInInfoCard(
                                height: 100,
                                color: const Color(0xffF1F8EC),
                                icon: const Icon(
                                  Icons.money,
                                  color: Color(0xff72AB3A),
                                ),
                                text: 'Automatically Generate Payroll',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              flex: 4,
                              child: SignInInfoCard(
                                height: 100,
                                color: const Color(0xffEAEEF6),
                                icon: const Icon(
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
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Employee Management System',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Help you to improve efficiency, accuracy, engagement, and cost savings for employees.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ShadButton(
                      size: ShadButtonSize.lg,
                      width: double.infinity,
                      onPressed: () {
                        // context.router.push(DashboardRoute());
                      },
                      child: const Text("I'm A Manager"),
                    ),
                    ShadButton.secondary(
                      size: ShadButtonSize.lg,
                      width: double.infinity,
                      onPressed: () {
                        // context.router.push(DashboardRoute());
                      },
                      child: const Text("I'm An Employee"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
}

class SignInInfoCard extends StatelessWidget {
  SignInInfoCard(
      {this.width, this.height, required this.color, required this.icon, required this.text});
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              )),
            )
          ],
        ),
      );
}
