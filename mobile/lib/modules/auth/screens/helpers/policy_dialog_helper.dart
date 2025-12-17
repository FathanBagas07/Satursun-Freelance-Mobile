import 'package:flutter/material.dart';
import '../../widgets/policy_dialog.dart';

class PolicyDialogHelper {
  static void show(
    BuildContext context, {
    required PolicyType type,
  }) {
    showDialog(
      context: context,
      builder: (_) => PolicyDialog(type: type),
    );
  }
}