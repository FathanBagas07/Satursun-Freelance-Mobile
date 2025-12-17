import 'package:flutter/material.dart';
import '../../widgets/policy_dialog.dart';

class PolicyDialogHelper {
  static void show(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (_) => PolicyDialog(
        title: title,
        content: content,
      ),
    );
  }
}
