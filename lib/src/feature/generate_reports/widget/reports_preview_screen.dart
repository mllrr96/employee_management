import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:employee_management/src/core/constant/generated/assets.gen.dart';
import 'package:employee_management/src/core/utils/extensions/context_extension.dart';
import 'package:employee_management/src/core/widget/employee_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class ReportsPreviewScreen extends StatelessWidget {
  const ReportsPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading:
              Platform.isIOS ? const CupertinoNavigationBarBackButton() : null,
          title: const Text(
            'Reports Preview',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(EmployeeIcons.excel),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reports Preview',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        '250 KB',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Opacity(
              opacity: 0.6,
              child: Image.asset(
                Assets.images.reportPreview.path,
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: context.bottomPadding,
          ),
          child: ShadButton(
            size: ShadButtonSize.lg,
            onPressed: () async {
              final directory = await getApplicationDocumentsDirectory();
              final String filePath =
                  join(directory.path, 'payrollJuly2024.xlsx');
              XFile xFile;
              if (File(filePath).existsSync()) {
                xFile = XFile(filePath);
              } else {
                // write file to local storage
                final ByteData data =
                    await rootBundle.load(Assets.files.payrollJuly2024);
                final List<int> bytes =
                    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                await File(filePath).writeAsBytes(bytes);
                xFile = XFile(filePath);
              }

              await Share.shareXFiles([xFile]);
            },
            icon: const Icon(Icons.share),
            child: const Text('Share'),
          ),
        ),
      );
}
