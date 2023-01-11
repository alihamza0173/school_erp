import 'package:flutter/material.dart';

class AppHelper {

  static Future<bool> showExitDiaologue(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('Exit the App'),
            content: const Text('Are you sure you want to Exit!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('ٹھیک ہے')),
            ],
          );
        }));
  }
}
