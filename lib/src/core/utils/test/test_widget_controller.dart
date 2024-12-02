import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// A controller for testing widgets.
class TestWidgetController {
  /// Creates a new instance of [TestWidgetController].
  const TestWidgetController(this.tester);

  /// The [WidgetTester] instance.
  final WidgetTester tester;

  /// Pumps the given [widget] and waits for the widget to be rendered.
  Future<void> pumpWidget(
    Widget widget, {
    bool wrapWithMaterialApp = true,
  }) async {
    var child = widget;

    if (wrapWithMaterialApp) {
      child = MaterialApp(home: child);
    }


    await tester.pumpWidget(child);
  }
}
