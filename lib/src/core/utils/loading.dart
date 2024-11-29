import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> loading({String? status}) async {
  await EasyLoading.show(
    status: status,
    maskType: EasyLoadingMaskType.black,
    indicator: LoadingAnimationWidget.threeArchedCircle(
      color: Colors.blue,
      size: 50,
    ),
  );
}

Future<void> dismissLoading() async {
  await EasyLoading.dismiss();
}
