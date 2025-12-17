import 'package:flutter/material.dart';
import 'package:satursun_app/modules/auth/enums/policy_type.dart';
import 'package:satursun_app/widgets/policy_dialog.dart';
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