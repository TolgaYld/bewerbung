import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';

class CustomSnackBar {
  const CustomSnackBar._();

  static void showSnackBar(
    BuildContext context,
    String message, {
    bool error = false,
  }) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: AutoSizeText(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? theme.colorScheme.error : theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacers.m),
          ),
          margin: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.3,
            right: MediaQuery.sizeOf(context).width * 0.3,
            bottom: MediaQuery.sizeOf(context).height * 0.04,
          ),
        ),
      );
  }
}
