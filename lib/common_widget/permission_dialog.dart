import 'package:flutter/material.dart';

import '../main.dart';

class PermissionDialog extends StatelessWidget {
  final String title;
  final VoidCallback? openAppSettings;
  final String message;

  const PermissionDialog({
    super.key,
    required this.title,
    required this.openAppSettings,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            if (openAppSettings != null) {
              openAppSettings!(); // Execute the callback
            }
          },
          child: const Text('Settings'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  static void show(String message, {VoidCallback? openAppSettings}) {
    showDialog(
      context: navigatorKey.currentState!.context,
      builder: (BuildContext context) {
        return PermissionDialog(
          title: 'Permission Required',
          message: message,
          openAppSettings: openAppSettings,
        );
      },
    );
  }
}